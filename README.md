## About

The goal of the project is to provide a personalized news feed. The curation will be based on Machine Learning (ML). Messages from public sources are automatically collected and classified according to the user's specifications. The presentation is non-linear according to topic areas and is sorted by relevance. Duplication of congruent content from different sources should be avoided and differences highlighted. The traceability and interpretability of the compilation is in the foreground. The user should interactively exercise control over the parameters of the underlying algorithms for classification and selection.


## Current situation (aka The Problem)

Messages are distributed in high frequency and high volumes in different formats across different media. The totality of publicly available data is growing exponentially. The diversity of the media and their reporting has a high priority for the formation of political opinions, but the processing of content-congruent information and the perspective interpretation of events requires at the same time a high personal effort. This contradiction leads to non-optimal compromises, e.g. self-restriction to singular sources (e.g. subscription) or use of black boxes (such as the Facebook Newsfeed).


## Our approach (aka The Solution)

For collecting news, we want to focus on open standards such as RSS (feeds). The software necessary to aggregate and analyze the data will be written in Python. In addition to the content of the articles, we also want to include metadata (such as publication date, article length, publisher, author and keywords). This data is stored in a structured manner. For the development of our prototype the validity and timeliness of the data is not in the foreground.

We will implement all ML models to be developed in the open-source ML framework PyTorch. The training of the models usually is computationally intensive. We will use cloud services or rented servers for this. The ML models are used for article classification, similarity determination and relevance control.

The components for querying the data sources and evaluating the different models are the backend of the software. For the usage we will set up a simple frontend based on common JavaScript frameworks (ReactJS / EmberJS). The frontend visualizes the sorted messages and offers the possibility to control the message selection. In addition, the automated decisions of the algorithms are visualized there.


## Roadmap

- Integration of the news feeds and construction of the database
- Development of ML procedures for classification of contents
- Development of a web interface for displaying the contents
- Integration of possibilities for user feedback
- Development of ML procedures for relevance assessment
- Development of ML models to group similar content


## License 

We have yet no decided under what license we will release our project's code, but in all likelihood it will be an open source license like the [MIT License](https://choosealicense.com/licenses/mit/) or [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/). 


## More information 

Check the [documentation](https://github.com/marianoju/selectDiff/docs) for more detailed information about the progress of this project. 

