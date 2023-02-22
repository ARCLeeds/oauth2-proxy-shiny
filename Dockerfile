# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

COPY ./demo_app/* /srv/shiny-server/
