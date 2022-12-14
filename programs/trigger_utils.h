#ifndef TRIGGER_UTILS_H
#define TRIGGER_UTILS_H

// Some tracker trigger constants useful for parsing
namespace trigger_utils
{
  inline constexpr std::size_t NGEIGER_MATRIX  = 2034;
  inline constexpr std::size_t NSIDES  = 2;
  inline constexpr std::size_t NLAYERS = 9;
  inline constexpr std::size_t NROWS   = 113;
  inline constexpr std::size_t NZONES_PER_SIDE  = 10;
  inline constexpr std::size_t NZONES_TOTAL  = 20;
  inline constexpr std::size_t NSLZONES = 31;
  inline constexpr std::size_t SLZONE_WIDTH = 8;
  inline constexpr std::size_t SLZONE_LAYER_PROJ = 9;
  inline constexpr std::size_t SLZONE_ROW_PROJ   = 8;

  inline constexpr std::size_t NGEIGER_PER_CRATE = 684;
  inline constexpr std::size_t NGEIGER_PER_TP = 36;
  inline constexpr std::size_t EVENT_BUFFER_FRAME_SIZE = 128;
  inline constexpr std::size_t EVENT_BUFFER_WORDS_SIZE = 41;
  inline constexpr std::size_t EVENT_BUFFER_GEIGER_MATRIX_WORDS_SIZE = 21;
  inline constexpr std::size_t ZONING_WORD_SIZE = 7;
  inline constexpr std::size_t BLANK_WORD_SIZE = 4;
  inline constexpr std::size_t LAST_BLANK_WORD_SIZE = 1;
  inline constexpr std::size_t SPECIAL_BLANK_WORD_SIZE = 84;


  inline constexpr std::size_t GEIGER_FIRST_ROW_START_INDEX = 0;
  inline constexpr std::size_t GEIGER_FIRST_ROW_STOP_INDEX = 8;
  inline constexpr std::size_t GEIGER_SECOND_ROW_START_INDEX = 9;
  inline constexpr std::size_t GEIGER_SECOND_ROW_STOP_INDEX = 17;
  inline constexpr std::size_t GEIGER_THIRD_ROW_START_INDEX = 18;
  inline constexpr std::size_t GEIGER_THIRD_ROW_STOP_INDEX = 26;
  inline constexpr std::size_t GEIGER_FOURHT_ROW_START_INDEX = 27;
  inline constexpr std::size_t GEIGER_FOURTH_ROW_START_INDEX = 35;

  inline constexpr std::size_t EVENT_BUFFER_SPECIAL_FRAME_INDEX_CB0 = 6;
  inline constexpr std::size_t EVENT_BUFFER_SPECIAL_FRAME_INDEX_CB1 = 13;
  inline constexpr std::size_t EVENT_BUFFER_SPECIAL_FRAME_INDEX_CB2 = 20;


}

#endif
