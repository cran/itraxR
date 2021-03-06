#' Make a spectrograph from raw Itrax data spectra files
#'
#' Parses a folder full of raw spectra files from an Itrax core scanner and produces a spectral graph of all the data by position
#'
#' @param foldername defines the folder where the spectra \code{"*.spe"} files are located
#' @param datapos defines the row at which spectral data begins in the files
#' @param plot TRUE/FALSE, selects whether to create a plot as a side-effect
#' @param trans transformation applied in the plot - see `?ggplot2::scales_colour_gradient()` for options
#'
#' @return a dataframe of all the spectral data
#'
#' @examples
#' \dontrun{itrax_restspectra("~/itraxBook/CD166_19_(2020)/CD166_19_S1/CD166_19_S1/XRF data")}
#'
#' @import dplyr ggplot2 readr
#'
#' @importFrom rlang .data
#'
#' @export

# function for integrating raw xrf spectra and visualising the same
itrax_restspectra <- function(foldername = "XRF data",
                              datapos=37,
                              plot = TRUE,
                              trans = "pseudo_log") {

  energy <- NULL
  name <- NULL
  position <- NULL
  value <- NULL

  # read in a list of files
  filenames <- dir(foldername, pattern="*.spe")
  filenames <- paste(foldername, filenames, sep="/")

  # import them all
  tables <- suppressWarnings(lapply(filenames,
                                    readr::read_delim,
                                    delim = "\t",
                                    skip = datapos,
                                    col_types = readr::cols_only(channel = readr::col_double(),
                                                                 content = readr::col_double()
                                                                 )
                                    )
                             )

  # import all the scan positions
  depths <- suppressWarnings(lapply(filenames,
                                    read.table,
                                    skip = 6,
                                    nrows = 1,
                                    header = FALSE)
                             )

  # label all the dataframes
  names(tables) <- unname(sapply(depths, `[[`, 2))

  # make an array where x=position, y=channel, and colour=intensity
  df <- unname(sapply(tables, `[[`, "content"))

  # label the cols and rows
  colnames(df) <- unname(sapply(depths, `[[`, 2))
  row.names(df) <- 1:dim(df)[1] * (17.5 / 1000) # 17.5 the MCA bin width

  # tidy-up
  rm(depths, tables, filenames, datapos)

  # draw a plot as a side-effect if required
  if(plot == TRUE){

    # pivot long
    df %>%
      as_tibble(rownames = "energy") %>%
      tidyr::pivot_longer(cols = -energy) %>%
      rename(position = name) %>%
      mutate(energy = as.numeric(energy),
             position = as.numeric(position)) %>%

    # plot
    ggplot(aes(x = energy, y = position, fill = value)) +
      geom_raster() +
      scale_fill_gradient(name = "value",
                          trans = trans,
                          low = "#132B43",
                          high = "#56B1F7",
                          labels = round) +
      scale_y_reverse() +
      xlab("energy [k eV]") +
      ylab("position [mm]") +
      guides(fill = FALSE) -> myPlot

    print(myPlot)

  }

  # returns
  return(df)
}
