# Swift API client for the LAMP Platform

## Overview
This API client is used to connect to the LAMP Platform from the Swift programming language. [Visit our documentation for more information about the LAMP Platform.](https://docs.lamp.digital/)

## Installation

### Prerequisites

```
TODO
```

### Configuration

```
TODO
```

## Documentation for API Endpoints

All URIs are relative to the `server_address` (by default, `api.lamp.digital`) with the `https://` protocol.

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*APIAPI* | [**aPIQuery**](docs/APIAPI.md#apiquery) | **POST** / | Query the LAMP Database.
*APIAPI* | [**aPISchema**](docs/APIAPI.md#apischema) | **GET** / | View the API schema document.
*ActivityAPI* | [**activityAll**](docs/ActivityAPI.md#activityall) | **GET** /activity | Get the set of all activities.
*ActivityAPI* | [**activityAllByParticipant**](docs/ActivityAPI.md#activityallbyparticipant) | **GET** /participant/{participant_id}/activity | Get all activities for a participant.
*ActivityAPI* | [**activityAllByResearcher**](docs/ActivityAPI.md#activityallbyresearcher) | **GET** /researcher/{researcher_id}/activity | Get all activities for a researcher.
*ActivityAPI* | [**activityAllByStudy**](docs/ActivityAPI.md#activityallbystudy) | **GET** /study/{study_id}/activity | Get all activities in a study.
*ActivityAPI* | [**activityCreate**](docs/ActivityAPI.md#activitycreate) | **POST** /study/{study_id}/activity | Create a new Activity under the given Study.
*ActivityAPI* | [**activityDelete**](docs/ActivityAPI.md#activitydelete) | **DELETE** /activity/{activity_id} | Delete an Activity.
*ActivityAPI* | [**activityUpdate**](docs/ActivityAPI.md#activityupdate) | **PUT** /activity/{activity_id} | Update an Activity&#39;s settings.
*ActivityAPI* | [**activityView**](docs/ActivityAPI.md#activityview) | **GET** /activity/{activity_id} | Get a single activity, by identifier.
*ActivityEventAPI* | [**activityEventAllByParticipant**](docs/ActivityEventAPI.md#activityeventallbyparticipant) | **GET** /participant/{participant_id}/activity_event | Get all activity events for a participant.
*ActivityEventAPI* | [**activityEventAllByResearcher**](docs/ActivityEventAPI.md#activityeventallbyresearcher) | **GET** /researcher/{researcher_id}/activity_event | Get all activity events for a researcher by participant.
*ActivityEventAPI* | [**activityEventAllByStudy**](docs/ActivityEventAPI.md#activityeventallbystudy) | **GET** /study/{study_id}/activity_event | Get all activity events for a study by participant.
*ActivityEventAPI* | [**activityEventCreate**](docs/ActivityEventAPI.md#activityeventcreate) | **POST** /participant/{participant_id}/activity_event | Create a new ActivityEvent for the given Participant.
*ActivityEventAPI* | [**activityEventDelete**](docs/ActivityEventAPI.md#activityeventdelete) | **DELETE** /participant/{participant_id}/activity_event | Delete a ActivityEvent.
*ActivitySpecAPI* | [**activitySpecAll**](docs/ActivitySpecAPI.md#activityspecall) | **GET** /activity_spec | Get all ActivitySpecs registered.
*ActivitySpecAPI* | [**activitySpecCreate**](docs/ActivitySpecAPI.md#activityspeccreate) | **POST** /activity_spec | Create a new ActivitySpec.
*ActivitySpecAPI* | [**activitySpecDelete**](docs/ActivitySpecAPI.md#activityspecdelete) | **DELETE** /activity_spec/{activity_spec_name} | Delete an ActivitySpec.
*ActivitySpecAPI* | [**activitySpecUpdate**](docs/ActivitySpecAPI.md#activityspecupdate) | **PUT** /activity_spec/{activity_spec_name} | Update an ActivitySpec.
*ActivitySpecAPI* | [**activitySpecView**](docs/ActivitySpecAPI.md#activityspecview) | **GET** /activity_spec/{activity_spec_name} | View an ActivitySpec.
*CredentialAPI* | [**credentialCreate**](docs/CredentialAPI.md#credentialcreate) | **POST** /type/{type_id}/credential | 
*CredentialAPI* | [**credentialDelete**](docs/CredentialAPI.md#credentialdelete) | **DELETE** /type/{type_id}/credential/{access_key} | 
*CredentialAPI* | [**credentialList**](docs/CredentialAPI.md#credentiallist) | **GET** /type/{type_id}/credential | 
*CredentialAPI* | [**credentialUpdate**](docs/CredentialAPI.md#credentialupdate) | **PUT** /type/{type_id}/credential/{access_key} | 
*ParticipantAPI* | [**participantAll**](docs/ParticipantAPI.md#participantall) | **GET** /participant | Get the set of all participants.
*ParticipantAPI* | [**participantAllByResearcher**](docs/ParticipantAPI.md#participantallbyresearcher) | **GET** /researcher/{researcher_id}/participant | Get the set of all participants under a single researcher.
*ParticipantAPI* | [**participantAllByStudy**](docs/ParticipantAPI.md#participantallbystudy) | **GET** /study/{study_id}/participant | Get the set of all participants in a single study.
*ParticipantAPI* | [**participantCreate**](docs/ParticipantAPI.md#participantcreate) | **POST** /study/{study_id}/participant | Create a new Participant for the given Study.
*ParticipantAPI* | [**participantDelete**](docs/ParticipantAPI.md#participantdelete) | **DELETE** /participant/{participant_id} | Delete a participant AND all owned data or event streams.
*ParticipantAPI* | [**participantUpdate**](docs/ParticipantAPI.md#participantupdate) | **PUT** /participant/{participant_id} | Update a Participant&#39;s settings.
*ParticipantAPI* | [**participantView**](docs/ParticipantAPI.md#participantview) | **GET** /participant/{participant_id} | Get a single participant, by identifier.
*ResearcherAPI* | [**researcherAll**](docs/ResearcherAPI.md#researcherall) | **GET** /researcher | Get the set of all researchers.
*ResearcherAPI* | [**researcherCreate**](docs/ResearcherAPI.md#researchercreate) | **POST** /researcher | Create a new Researcher.
*ResearcherAPI* | [**researcherDelete**](docs/ResearcherAPI.md#researcherdelete) | **DELETE** /researcher/{researcher_id} | Delete a researcher.
*ResearcherAPI* | [**researcherUpdate**](docs/ResearcherAPI.md#researcherupdate) | **PUT** /researcher/{researcher_id} | Update a Researcher&#39;s settings.
*ResearcherAPI* | [**researcherView**](docs/ResearcherAPI.md#researcherview) | **GET** /researcher/{researcher_id} | Get a single researcher, by identifier.
*SensorAPI* | [**sensorAll**](docs/SensorAPI.md#sensorall) | **GET** /sensor | Get the set of all sensors.
*SensorAPI* | [**sensorAllByParticipant**](docs/SensorAPI.md#sensorallbyparticipant) | **GET** /participant/{participant_id}/sensor | Get all sensors for a participant.
*SensorAPI* | [**sensorAllByResearcher**](docs/SensorAPI.md#sensorallbyresearcher) | **GET** /researcher/{researcher_id}/sensor | Get all sensors for a researcher.
*SensorAPI* | [**sensorAllByStudy**](docs/SensorAPI.md#sensorallbystudy) | **GET** /study/{study_id}/sensor | View all sensors in a study.
*SensorAPI* | [**sensorCreate**](docs/SensorAPI.md#sensorcreate) | **POST** /study/{study_id}/sensor | Create a new Sensor under the given Study.
*SensorAPI* | [**sensorDelete**](docs/SensorAPI.md#sensordelete) | **DELETE** /sensor/{sensor_id} | Delete a Sensor.
*SensorAPI* | [**sensorUpdate**](docs/SensorAPI.md#sensorupdate) | **PUT** /sensor/{sensor_id} | Update an Sensor&#39;s settings.
*SensorAPI* | [**sensorView**](docs/SensorAPI.md#sensorview) | **GET** /sensor/{sensor_id} | Get a single sensor, by identifier.
*SensorEventAPI* | [**sensorEventAllByParticipant**](docs/SensorEventAPI.md#sensoreventallbyparticipant) | **GET** /participant/{participant_id}/sensor_event | Get all sensor events for a participant.
*SensorEventAPI* | [**sensorEventAllByResearcher**](docs/SensorEventAPI.md#sensoreventallbyresearcher) | **GET** /researcher/{researcher_id}/sensor_event | Get all sensor events for a researcher by participant.
*SensorEventAPI* | [**sensorEventAllByStudy**](docs/SensorEventAPI.md#sensoreventallbystudy) | **GET** /study/{study_id}/sensor_event | Get all sensor events for a study by participant.
*SensorEventAPI* | [**sensorEventCreate**](docs/SensorEventAPI.md#sensoreventcreate) | **POST** /participant/{participant_id}/sensor_event | Create a new SensorEvent for the given Participant.
*SensorEventAPI* | [**sensorEventDelete**](docs/SensorEventAPI.md#sensoreventdelete) | **DELETE** /participant/{participant_id}/sensor_event | Delete a sensor event.
*SensorSpecAPI* | [**sensorSpecAll**](docs/SensorSpecAPI.md#sensorspecall) | **GET** /sensor_spec | Get all SensorSpecs registered.
*SensorSpecAPI* | [**sensorSpecCreate**](docs/SensorSpecAPI.md#sensorspeccreate) | **POST** /sensor_spec | Create a new SensorSpec.
*SensorSpecAPI* | [**sensorSpecDelete**](docs/SensorSpecAPI.md#sensorspecdelete) | **DELETE** /sensor_spec/{sensor_spec_name} | Delete an SensorSpec.
*SensorSpecAPI* | [**sensorSpecUpdate**](docs/SensorSpecAPI.md#sensorspecupdate) | **PUT** /sensor_spec/{sensor_spec_name} | Update an SensorSpec.
*SensorSpecAPI* | [**sensorSpecView**](docs/SensorSpecAPI.md#sensorspecview) | **GET** /sensor_spec/{sensor_spec_name} | Get a SensorSpec.
*StudyAPI* | [**studyAll**](docs/StudyAPI.md#studyall) | **GET** /study | Get the set of all studies.
*StudyAPI* | [**studyAllByResearcher**](docs/StudyAPI.md#studyallbyresearcher) | **GET** /researcher/{researcher_id}/study | Get the set of studies for a single researcher.
*StudyAPI* | [**studyCreate**](docs/StudyAPI.md#studycreate) | **POST** /researcher/{researcher_id}/study | Create a new Study for the given Researcher.
*StudyAPI* | [**studyDelete**](docs/StudyAPI.md#studydelete) | **DELETE** /study/{study_id} | Delete a study.
*StudyAPI* | [**studyUpdate**](docs/StudyAPI.md#studyupdate) | **PUT** /study/{study_id} | Update the study.
*StudyAPI* | [**studyView**](docs/StudyAPI.md#studyview) | **GET** /study/{study_id} | Get a single study, by identifier.
*TypeAPI* | [**typeGetAttachment**](docs/TypeAPI.md#typegetattachment) | **GET** /type/{type_id}/attachment/{attachment_key} | 
*TypeAPI* | [**typeGetDynamicAttachment**](docs/TypeAPI.md#typegetdynamicattachment) | **GET** /type/{type_id}/attachment/dynamic/{attachment_key} | 
*TypeAPI* | [**typeListAttachments**](docs/TypeAPI.md#typelistattachments) | **GET** /type/{type_id}/attachment | 
*TypeAPI* | [**typeParent**](docs/TypeAPI.md#typeparent) | **GET** /type/{type_id}/parent | Find the owner(s) of the resource.
*TypeAPI* | [**typeSetAttachment**](docs/TypeAPI.md#typesetattachment) | **PUT** /type/{type_id}/attachment/{attachment_key}/{target} | 
*TypeAPI* | [**typeSetDynamicAttachment**](docs/TypeAPI.md#typesetdynamicattachment) | **PUT** /type/{type_id}/attachment/dynamic/{attachment_key}/{target} | 


## Documentation For Models

 - [AccessCitation](docs/AccessCitation.md)
 - [Activity](docs/Activity.md)
 - [ActivityEvent](docs/ActivityEvent.md)
 - [ActivitySpec](docs/ActivitySpec.md)
 - [Credential](docs/Credential.md)
 - [Document](docs/Document.md)
 - [DurationInterval](docs/DurationInterval.md)
 - [DurationIntervalLegacy](docs/DurationIntervalLegacy.md)
 - [DynamicAttachment](docs/DynamicAttachment.md)
 - [Metadata](docs/Metadata.md)
 - [ModelError](docs/ModelError.md)
 - [Participant](docs/Participant.md)
 - [Researcher](docs/Researcher.md)
 - [Sensor](docs/Sensor.md)
 - [SensorEvent](docs/SensorEvent.md)
 - [SensorSpec](docs/SensorSpec.md)
 - [Study](docs/Study.md)
 - [TemporalSlice](docs/TemporalSlice.md)
