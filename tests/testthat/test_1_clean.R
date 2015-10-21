
# This test suite assumes that
# The package contains a test dataset called sawnwoodexample.
swd <- tradeflows::sawnwoodexample



context("Clean functions")
test_that("Price and conversion factorcalculation, deals with NA", {
    dtf <- data.frame(weight = c(1,NA,5),
                      quantity = c(2,4,6),
                      tradevalue = c(3,NA,7))
    dtf2 <- dtf %>%
        addconversionfactorandprice()
    expect_that(dtf$tradevalue / dtf$quantity,
                    equals(dtf2$price))
    expect_that(dtf$weight / dtf$quantity,
                equals(dtf2$conversion))
})


test_that("Grouping works in priceextraction", {
    dtf <- data.frame(price = rnorm(3,10),
                      aggregationregion = c("a","a","b"))

    message("Use a different geoaggregation level in clean")

})



context("Clean functions do not change total quantity")
# Test that the total quantity before and after applying each
# cleaning function remains the same. Or that at least the number of
# rows stays the same
test_that("addregion() doesn't change total quantity", {
    swd2 <- addregion(swd)
    expect_that(sum(swd$quantity, na.rm=TRUE),
                equals(sum(swd2$quantity, na.rm=TRUE)))
    expect_that(sum(swd$tradevalue, na.rm=TRUE),
                equals(sum(swd2$tradevalue, na.rm=TRUE)))
    expect_that(sum(swd$weight, na.rm=TRUE),
                equals(sum(swd2$weight, na.rm=TRUE)))
})

test_that("addconversionfactorandprice() doesn't change total quantity",{
    swd2 <- addconversionfactorandprice(swd)
    expect_that(sum(swd$quantity, na.rm=TRUE),
                equals(sum(swd2$quantity, na.rm=TRUE)))
})

# message("Currently using sawnwoodexample, but
# estimatequantity() would require a full dataset with all
# world trade flows for one product to prepare conversion factors and prices")
# That would be an integration test
test_that("The total quantity remains approximately the same after
          estimatequantity().",{
#     swd2 <- swd %>% addregion %>% addconversionfactorandprice %>%
#               estimatequantity
#     stop("estimatequantity() would require a full dataset
#               to prepare conversion factors and prices")
          })
