resource "aws_internet_gateway" "onlyflights-igw" {
    vpc_id = "${aws_vpc.onlyflights-vpc.id}"

    tags = {
        Name = "OnlyFlights IGW"
    }
}
