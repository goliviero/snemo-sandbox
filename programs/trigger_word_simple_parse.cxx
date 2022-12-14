// Standard library:
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iostream>
#include <exception>
#include <stdexcept>
#include <memory>
#include <string>
#include <vector>
#include <bitset>

// Third party libraries:

// This work
#include"trigger_utils.h"

// Define a type alias for a 2x9x113 array
using Matrix = std::array<std::array<std::array<bool, trigger_utils::NROWS>, trigger_utils::NLAYERS>, trigger_utils::NSIDES>;

struct event_buffer {

  void make_final_event_buffer_bitset() {
    std::string temp_final_event_buffer_string = this->blank_last.to_string() + this->TSZB.to_string() + this-> blank_third.to_string() + this->TP_from_CB_third.to_string() + this->blank_second.to_string() + this->TP_from_CB_second.to_string() + this->blank_first.to_string() + this->TP_from_CB_first.to_string();
    std::bitset<trigger_utils::EVENT_BUFFER_FRAME_SIZE> temp_final_event_buffer_bitset(temp_final_event_buffer_string);
    final_event_buffer_bitset = temp_final_event_buffer_bitset;
    return;
  };

  void display_frame() {
    std::clog << this->final_event_buffer_bitset << std::endl;
  }


  std::bitset<trigger_utils::NGEIGER_PER_TP> TP_from_CB_first{0x0};  // 36 bits
  std::bitset<trigger_utils::BLANK_WORD_SIZE> blank_first{0x0}; // 4 bits
  std::bitset<trigger_utils::NGEIGER_PER_TP> TP_from_CB_second{0x0}; // 36 bits
  std::bitset<trigger_utils::BLANK_WORD_SIZE> blank_second{0x0}; // 4 bits
  std::bitset<trigger_utils::NGEIGER_PER_TP> TP_from_CB_third{0x0}; // 36 bits
  std::bitset<trigger_utils::BLANK_WORD_SIZE> blank_third{0x0}; // 4 bits
  std::bitset<trigger_utils::ZONING_WORD_SIZE> TSZB{0x0}; // 7 bits
  std::bitset<trigger_utils::LAST_BLANK_WORD_SIZE> blank_last{0x0};  // 1 bit

  std::bitset<trigger_utils::EVENT_BUFFER_FRAME_SIZE> final_event_buffer_bitset{0x0}; // 128 bits

};


struct trigger_frame {

  void convert_matrix_to_event_buffer() {

    for (int side = 0; side < trigger_utils::NSIDES; side++) {
        for (int row = 0; row < trigger_utils::NROWS; row++) {
          for (int layer = 0; layer < trigger_utils::NLAYERS; layer++) {

            // Layout Geiger cell for a given FEB n
            //
            // [17;16;15;14;13;12;11;10;09] | [27;28;29;30;31;32;33;34;35] row (i+1)
            // [08;07;06;05;04;03;02;01;00] | [18;19;20;21;22;23;24;25;26] row (i)
            //
            // 128 bits in event buffer 3 FEBs in 1 word: [0][7][0000][36][0000][36][00000][36] Feb n+2; n+1; n

            if (side == 0) {
              // Side 0
              // For the side 0, layer are not in the right order. 9 from matrix is 0 in the frame, 8-1, 7-2 ...

              // For the rows, should do a modulo to split the detector in 3 third like in the CBs

              // Example: where to place row 1 ? row 23 ? special case row 55 ? row 60 ? row 85 ? row 112 ?
              // In TB code in verilog: 3 x 36 bits (i.e 2 FEB) in 1 word of 128


              // if (row == 56 && 57) Special treatment because the row 56 is alone in CB1 FEB 9 and then for 57 CB1 FEB 10 (induce a shift in the numerotation)`

            } else {
              // Side 1


            }
          } // end of layer
        } // end of row
    } // end of side


    return;
  };

  void display_all_frames() {
    for (std::size_t n = 0; n < trigger_utils::EVENT_BUFFER_WORDS_SIZE; n++) {
      eb[n].display_frame();
    }
    std::clog << std::endl;

    return;
  }

  void display_geiger_matrix() {

    std::clog << "Event #" << this->event_number << std::endl;
    for (int i = 0; i < trigger_utils::NSIDES; i++) {
      for (int j = 0; j < trigger_utils::NLAYERS; j++) {
        for (int k = 0; k < trigger_utils::NROWS; k++) {
          if (this->input_geiger_matrix[i][j][k]) std::clog << "*";
          else std::clog << ".";
        }
        std::clog << std::endl;
      }
    }
    std::clog << std::endl;
  }


  // Event number
  std::size_t event_number = -1;

  // Event buffer sent by the Trigger Board. 41 words of 128 bits to retrieve
  event_buffer eb[trigger_utils::EVENT_BUFFER_WORDS_SIZE];

  // Declare a three-dimensional array of size 2x9x113
  Matrix input_geiger_matrix;

};


struct trigger_word {

  std::bitset<trigger_utils::NGEIGER_MATRIX> geiger_matrix{0x0};
  std::array<std::bitset<trigger_utils::ZONING_WORD_SIZE>,  trigger_utils::NZONES_TOTAL>  trigger_word{0x0};

  // Declare a three-dimensional array of size 2x9x113
  Matrix output_geiger_matrix;

};

void read_matrices_from_file(std::vector<trigger_frame> &,
                             std::size_t);

void generate_trigger_frames(std::vector<trigger_frame> &);

void convert_frame_to_word(const trigger_frame &,
                           trigger_word &);

void check_trigger_word(const trigger_word &);

void display_trigger_word(const trigger_frame &,
                          const trigger_word &);

//----------------------------------------------------------------------
// MAIN PROGRAM
//----------------------------------------------------------------------

int main (int argc, char *argv[])
{
  int error_code = EXIT_SUCCESS;
  try {
    bool is_debug = false;
    bool is_verbose = false;
    size_t data_count = 2;

    for (int iarg=1; iarg<argc; ++iarg)
      {
        std::string arg (argv[iarg]);
        if (arg[0] == '-')
          {
            if ((arg == "-d") || (arg == "--debug"))
              is_debug  = true;

            else if ((arg == "-v") || (arg == "--verbose"))
              is_verbose = true;

            // else if ((arg=="-i") || (arg=="--input"))
            //   input_filename = std::string(argv[++iarg]);
            //
            // else if ((arg=="-o") || (arg=="--output"))
            //   output_filename = std::string(argv[++iarg]);

            else if ((arg == "-n") || (arg == "--max-events"))
              data_count = std::strtol(argv[++iarg], NULL, 10);

            else if (arg=="-h" || arg=="--help")
              {
                std::cout << std::endl;
                std::cout << "Usage:   " << argv[0] << " [options]" << std::endl;
                std::cout << std::endl;
                std::cout << "Options:   -h / --help" << std::endl;
                std::cout << "           -d / --debug    Debug logs" << std::endl;
                std::cout << "           -v / --verbose  More logs" << std::endl;
                std::cout << "           -n / --nevents  Number of events" << std::endl;
                std::cout << std::endl;
                return 0;
              }

            else
              std::clog << "Ignoring option '" << arg << "' !" << std::endl;
          }
      }

    // Seed the random number generator
    std::srand(std::time(nullptr));

    // Open the input file
    std::ifstream input_file("../programs/geiger_matrices.txt");
    if (!input_file.is_open()) {
      std::cerr << "Failed to open input file" << std::endl;
      return 1;
    }


    std::vector<trigger_frame> vtf;

    read_matrices_from_file(vtf, data_count);

    generate_trigger_frames(vtf);

    // std::clog << "  - Data count  : " << data_count << std::endl;

    // snfee::terminate();

    // DT_LOG_INFORMATION(logging, "The end.");
  }


  catch (std::exception & x) {
    // DT_LOG_FATAL(logging, x.what());
    error_code = EXIT_FAILURE;
  }
  catch (...) {
    //DT_LOG_FATAL(logging, "unexpected error !");
    error_code = EXIT_FAILURE;
  }
  return (error_code);
}

void read_matrices_from_file(std::vector<trigger_frame> & vtf_,
                             std::size_t nevents_) {
  std::clog << "Entering read_matrices_from_file..." << std::endl;
  // Open the input file
  std::ifstream input_file("../programs/geiger_matrices.txt");
  // Check if the file was successfully opened
  if (!input_file.is_open())
    {
      std::cerr << "Error: Could not open input file" << std::endl;
      return;
    }

  std::vector<std::vector<std::string> > string_input_matrix_events;

  // Read the contents of the file line by line
  std::string line;
  std::vector<std::string> string_matrix;
  std::size_t line_counter;
  while (std::getline(input_file, line))
    {
      if (line.find("Event") != std::string::npos) { }
      else string_matrix.push_back(line);

      if (line.empty()) {
        string_input_matrix_events.push_back(string_matrix);
        string_matrix.clear();
      }
      if (string_input_matrix_events.size() == nevents_) break;

      line_counter++;
    }

  std::clog << "Size of events = " << string_input_matrix_events.size() << std::endl;
  // Print the events to verify that they were stored correctly
  // for (std::size_t i = 0; i < string_input_matrix_events.size(); i++)
  //   {
  //     for (std::size_t j = 0; j < string_input_matrix_events[i].size(); j++)
  //       {
  //         std::clog << string_input_matrix_events[i][j] << std::endl;
  //       }
  //     std::clog << std::endl;
  //   }

  // The input file can be closed now because it has been parsed and stored
  input_file.close();

  // Have to convert string matrices line by line (18x113) into bool matrix trigger frames (2x9x113) in the right order
  for (std::size_t n = 0; n < nevents_; n++) {
    Matrix input_matrix = {{{{0}}}}; // create an instance of our Matrix structure


    for (std::size_t layer = 0; layer < string_input_matrix_events[n].size(); layer++) {
      const std::string & layer_string = string_input_matrix_events[n][layer];

      std::size_t side = -1;
      // Split in the middle when layer = 9
      if (layer >= 0 && layer < 9) {
        // Side 0:
        side = 0;
        for(std::size_t r = 0; r < layer_string.size(); r++) {
          if (layer_string[r] != '.') input_matrix[side][layer][r] = true;
          else input_matrix[side][layer][r] = false;
        }
      }
      else if (layer >= 9 && layer < 18) {
        // Side 1:
        side = 1;
        for(std::size_t r = 0; r < layer_string.size(); r++) {
          if (layer_string[r] != '.') input_matrix[side][layer - 9][r] = true;
          else input_matrix[side][layer][r] = false;
        }
      }
    } // end of row

    trigger_frame tf;
    tf.event_number = n;
    tf.input_geiger_matrix = input_matrix;
    vtf_.push_back(tf);

  } // end of nevents

  return;
}

void generate_trigger_frames(std::vector<trigger_frame> & vtf_) {
  std::clog << "Entering generate_trigger_frames..." << std::endl;


  // tf.eb[0].TP_from_CB_first.set();
  // tf.eb[0].TP_from_CB_second.set();
  // tf.eb[0].TP_from_CB_third.set();
  // tf.eb[0].TSZB.set();
  for (std::size_t n = 0; n < vtf_.size(); n++) {
    vtf_[n].display_geiger_matrix();
    vtf_[n].convert_matrix_to_event_buffer();
    vtf_[n].display_all_frames();
  }

  // // Loop on the size of the trigger frame
  // for (std::size_t i = 0; i < trigger_utils::EVENT_BUFFER_WORDS_SIZE; i++) {
  //   // Fill these 128 bits with values
  //   // These 128 bits are split :   [1][7][4][36][4][36][4][36]
  //   //      [blank][Trigger_word][blank][TPZ_from_CB][blank][TPY_from_CB][blank][TPX_from_CB]

  // }
  // std::clog << "Before make = " << tf.eb[0].final_event_buffer_bitset << std::endl;

  // tf.eb[0].make_final_event_buffer_bitset();

  // std::clog << "After make = " << tf.eb[0].final_event_buffer_bitset << std::endl;

  //  vtf_.push_back(tf);

  return;
}

void convert_frame_to_word(const trigger_frame & tf_,
                           trigger_word & tw_) {
  return;
}

void check_trigger_word(const trigger_word & tw_) {
  return;
}

void display_trigger_word(const trigger_frame & tf_,
                          const trigger_word & tw_) {
  return;
}
