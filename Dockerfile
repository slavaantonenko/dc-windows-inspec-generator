FROM microsoft/windowsservercore:latest

# ARG proxy=Proxy address
# ENV http_proxy=$proxy
# ENV https_proxy=$http_proxy

# ENV no_proxy=Proxies

COPY chef c:/opscode/chef
#COPY librarian C:/opt/librarian-chef
#RUN setx PATH '%PATH%;C:\\opscode\\chef\\embedded\\bin;c:\\opt\\librarian-chef\\bin'
RUN setx PATH "%PATH%;C:\opscode\chef\embedded\bin"
RUN mkdir c:\\inspec-gen
RUN mkdir c:\\tmp
COPY build-scripts/*.* c:/inspec-gen/
RUN gem install berkshelf
ENV BERKSPATH=/inspec-gen/
CMD cmd.exe
#versioning tags
ARG version_arg=1.0
#label the image
LABEL version=$version_arg