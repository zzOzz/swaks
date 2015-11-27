FROM perl
MAINTAINER Vincent Lombard <vincent.lombard@gmail.com>

# To run the image, pass SERVER, FROM, TO, RUNS, and JOBS to the image, for example:
#
# docker run -h <fqdn> -e SERVER=smtp.example.com -e FROM=me@example.com -e TO=you@example.com -e RUNS=100 -e JOBS=3 <imageId>

# Install packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install swaks parallel

# Add our script
ADD sendmail.sh /sendmail.sh
RUN chmod 755 /sendmail.sh
ENTRYPOINT ["/sendmail.sh"]
