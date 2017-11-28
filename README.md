# AS-E SeeDev
intro.adoc provides the main explanation of this work.

Execution_resources.sh is the initial script to prep-process the resources of this use-case application. 

It allows first, to transform the initial resources (in the repository "Resources"). Then it allows the expander generation with the "alvisir-index-expander" tool and the configuration (configuration/expander.xml). 

Finally, the script could execute the AlvisNLP plan (located in plan/entities.plan), on the corpus composed by html files (not available on GitHub) and converted with the configuration/html2alvisnlp.xslt file. 

The web application AlvisIR Search Engine is available : http://bibliome.jouy.inra.fr/demo/seedev/alvisir/webapi/search 
The documentation is available in  https://github.com/openminted/uc-tdm-AS-E/tree/master/documentation

The configuration of this tool need the configuration/UIConfig.xml and configuration/search.xml files 

Prerequisites

    AlvisNLP : https://github.com/Bibliome/alvisnlp
    AlvisIR : https://github.com/Bibliome/alvisir 
