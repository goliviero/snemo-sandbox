// Standard library:
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iostream>
#include <exception>
#include <stdexcept>
#include <algorithm>
#include <memory>
#include <vector>
#include <string>
#include <bitset>

// Third party libraries:

// This work
#include"trigger_utils.h"

// Define a type alias for a 2x9x113 array
using Matrix = std::array<std::array<std::array<bool, trigger_utils::NROWS>, trigger_utils::NLAYERS>, trigger_utils::NSIDES>;

void generate_geiger_matrix();

// Option to generate 1 track event / 2 tracks event / same side / back to back etc etc...



// MAIN PROGRAM
//----------------------------------------------------------------------

int main (int argc, char *argv[])
{
  int error_code = EXIT_SUCCESS;
  try {
    bool is_debug = false;
    bool is_verbose = false;
    size_t data_count = 3;
    std::string output_filename = "../programs/geiger_matrices.txt";

    for (int iarg=1; iarg<argc; ++iarg)
      {
        std::string arg (argv[iarg]);
        if (arg[0] == '-')
          {
            if ((arg == "-d") || (arg == "--debug"))
              is_debug  = true;

            else if ((arg == "-v") || (arg == "--verbose"))
              is_verbose = true;

            else if ((arg=="-o") || (arg=="--output"))
              output_filename = std::string(argv[++iarg]);

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

    // Open the output file
    std::ofstream output_file(output_filename);
    if (!output_file.is_open()) {
      std::cerr << "Failed to open output file" << std::endl;
      return 1;
    }

    // Declare a three-dimensional array of size 2x9x113
    std::vector<Matrix> geiger_matrices;

    for (int n = 0; n < data_count; ++n) {

      // Create a 2x9x113 array and initialize its elements
      Matrix geiger_matrix = {{{{0}}}};

      // First matrix is empty
      if (n == 0) geiger_matrices.push_back(geiger_matrix);
      // Last matrix is full
      else if (n == data_count - 1) {
        // fill the matrix with the value true
        for (auto& side : geiger_matrix) {
          for (auto& layer : side) {
            for (auto& row : layer) {
              //geiger_matrix[side][layer][row] = true;
              row = true;
            }
          }
        }
        geiger_matrices.push_back(geiger_matrix);
      }
      // Otherwise random values in the matrix
      else {
        for (int i = 0; i < trigger_utils::NSIDES; i++) {
          for (int j = 0; j < trigger_utils::NLAYERS; j++) {
            for (int k = 0; k < trigger_utils::NROWS; k++)  {
              // Generate a random number between 0 and 1
              int r = rand() % 2;
              // Assign the value to the corresponding element in the matrix
              geiger_matrix[i][j][k] = (r == 1);
            }
          }
        }
        geiger_matrices.push_back(geiger_matrix);
      }
    }

    // Write the Geiger matrices to the output file
    for (std::size_t n = 0; n < geiger_matrices.size(); n++) {
      output_file << "Event #" << n << std::endl;
      for (int i = 0; i < trigger_utils::NSIDES; i++) {
        for (int j = 0; j < trigger_utils::NLAYERS; j++) {
          for (int k = 0; k < trigger_utils::NROWS; k++)  {
            if (geiger_matrices[n][i][j][k]) output_file << j; // "*"; !! DO NOT FORGET TO CHANGE BACK WITH THE STAR CHARACTER !!
            else output_file << ".";
          }
          output_file << std::endl;
        }
        //        output_file << std::endl;
      }
      output_file << std::endl;
    }

    // Close the file stream
    output_file.close();
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
