#!/usr/bin/env bash

exec bundle exec rails runner 'InitImportWorker.call'
