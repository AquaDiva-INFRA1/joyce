# Jena Ontology Customization Engine (JOYCE)

## Overview

[Ontologies](https://en.wikipedia.org/wiki/Ontology_(information_science)) are formal structures to represent knowledge about some domain. In short, they consist of a class hierarchy and formally defined relations between these classes allowing to test whether (formally defined) statements about classes are true or false or to derive knowledge that has not been explicitly encoded into the ontology.

In the biological scientific domain, a large range of ontologies have been built covering a diverse set of topics. Many of them are hosted by [BioPortal](http://bioportal.bioontology.org/). When starting a new application or project where ontologies should be used, BioPortal is a good place to start in order to find ontologies covering the required concepts. However, in a lot of cases, not a single ontology will suffice for a given use case and, on the other hand, most ontologies might model more that would be required. This is where JOYCE is useful.

This project serves the purpose of reusing (parts of) already existing ontologies for new projects, applications and requirements. To this end, it builds an ontology repository of its own, currently by downloading ontologies from BioPortal. Then, these ontologies are split into pre-computed modules to allow a fine-grained conceptual coverage of some topic at hand.

At the ontology module selection step, users give text as input in which ontology concepts are automatically detected. On the cases of found concept mentions, eligible ontology modules are determined. Then, an optimization algorithm finds sets of ontology modules covering the input text with as less overhead as possible and returns the respective modules.

Note that there is currently no alignment done on the output modules.

## Building JOYCE

### Prerequisites

You will require a [Maven 3.x](https://maven.apache.org/) installation or IDE plugin to successfully build JOYCE.

### Download and building

1. Clone the complete repository with its submodules (see section below). If you want to develop JOYCE, it would be a good idea to checkout the correct branch (could be master) of each submodule since submodules point by default at a specific commit, not at a branch.
2. Clone the SkySim_Maven project from the AquaDiva-INFRA1 organization.
3. Clone the `aquadiva-neo4j-plugins` project from the AquaDiva-INFRA1 organization.
4. Do `mvn clean install` for the SkySim_Maven project.
5. Do `mvn clean install`for the aquadiva-neo4j-plugins project.
6. Do `mvn clean install` on the cloned JOYCE root project. Note that you will not be able to build the subprojects on their own until you have executed the Maven install goal on the root project (joyce) at least once. 

## Using JOYCE

To create a fresh instance of JOYCE, the first step is to build the JOYCE ontology module repository. After this first step, module selection can be performed given input text files mentioning ontology concepts that are included in the repository.

JOYCE can be used from the command line and by a web frontend. Note that the initial setup process requires the use of the command line interface.

### Command line interface
After a successful build, the *joyce-processes* subproject will contain an executable JAR file in its *target/* directory. The file will be called *joyce-processes-&lt;version&gt;.jar*. Start it from the command line via *java -jar <path to the executable JAR file>*. A menu will appear that will guide you through the desired process.
  
### Web interface
The subproject *joyce-webapp* contains a [Tapestry 5](http://tapestry.apache.org/) web application. To start it, build JOYCE as described in the *Building JOYCE* section above and deploy the resulting WAR file into a servlet container, e.g. [Jetty](https://www.eclipse.org/jetty/). Alternatively, you can start the application directly from Eclipse after you installed the [Eclipse Jetty Integration](http://eclipse-jetty.github.io/) plugin.

## Structure of the project

The whole JOYCE project consists of this very repository that links to the other JOYCE repositories via git submodules. If you are developing JOYCE you might want to read an introduction regarding this topic.

The other repositories are

- joyce-base: Very basic service for working with ontologies.
- joyce-core: Code for the special features of JOYCE like modularization and scoring
- joyce-reasoning: Was originally meant for reasoning-related scores, not used until today.
- joyce-processes: JOYCE services and applications for setting up the ontology repository and performing ontology module selection.
- joyce-evaluation: Evaluation code for JOYCE and the NCBO Annotator.
- joyce-webapp: A Tapestry web application employing joyce-processes for web-interfaced module selection.

The complete JOYCE project is managed via [Apache Maven](http://maven.apache.org/). The pom.xml of each (sub-)project is the project description and management file. This is where dependencies to other libraries are put into, the Java JVM version is defined and a range of other project management related stuff. The main POM is the one in this project, the subprojects are added as Maven modules in this very POM.

### Service Framework and IoC Container

The project uses [Apache Tapestry](http://tapestry.apache.org/) for its service architecture. Tapestry provides an [IoC](https://en.wikipedia.org/wiki/Inversion_of_control) (Inversion of Control) registry and also a web framework for the JOYCE web application.
