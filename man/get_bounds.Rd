% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/view_bounds.R
\name{get_bounds}
\alias{get_bounds}
\title{Get Face Bounds}
\usage{
get_bounds(xml, crop = FALSE, subset = NULL)
}
\arguments{
\item{xml}{The file path for the XML file created by \code{\link[=tem_to_xml]{tem_to_xml()}}}

\item{crop}{Whether to crop the image to the bounds}

\item{subset}{indices of images to subset}
}
\value{
A stimlist with a 4-point template of the top-left, top-right, bottom-right, and bottom-left corners of the bounding box, optionally cropped to this box
}
\description{
Get the bounds detected by \code{\link[=tem_to_xml]{tem_to_xml()}} (uses dlib.get_frontal_face_detector()).
}
\examples{
xml <- system.file("demo/_images.xml", package = "webmorphR.dlib")
bounds <- get_bounds(xml)
cropped <- get_bounds(xml, crop = TRUE)

\dontrun{
  # plot images
  bounds |>
    draw_tem(line.alpha = 1, line.color = "green") |>
    c(cropped) |>
    plot(nrow = 1)
}
}
