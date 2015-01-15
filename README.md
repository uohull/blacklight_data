# blacklight_data

This is a proof of concept application that enables the indexing of arbitary CSV files in Apache solr.  The application utilises Blacklight to enable search and browse of the indexed data.  

The initial concept:-

* Upload 1 or more data files (these could be various versions of the same dataset)
* Index the dataset (at present only one can be indexed at a time in Solr)
 - The application enables you to make some decisions about the data you are indexing (i.e. Searchable, displayable, facetable, sortable etc..)

* Use Blacklight configuration form to choose what is displayed in the various Blacklight views (Show, Index, Facets, Search, Sort), this is based upon the choices made when the Dataset was indexed.  

## Installation

Clone the repository 

```
git clone https://github.com/uohull/blacklight_data.git
```

Change the current directory to 'blacklight_data'.  

The application uses blacklight_jetty for to provide an instance of jetty and solr.  To download the necessary files, run:

```
git submodule init
git submodule update
```  

Install the required Gems:

```
bundle install
```

Migrate the database

```
rake db:migrate
```

Configure Solr with the application configurations:

```
rake jetty:config_solr
```

## Running

First start the jetty instance:

```
rake jetty:start
```

To start the application:

```
rails s
```


## Test

Tests exist for the core funtionality within /lib/hull/* and the models directory.  controller/view tests required (currently pending).  

The tests are written using rspec.  First migrate the test db:

```
RAILS_ENV=test rake db:migrate
```

To run the tests: 

```
bundle exec rspec
```
