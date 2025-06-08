# Rickipedia

The project involves utilizing the Rick and Morty API to populate a mobile app that displays characters, locations, and episodes. The REST API is central to accessing various resources, with all requests being made over HTTPS and returning JSON data. The app includes features for filtering and sorting characters, episodes, and locations using SwiftUI and following an MVVM architecture.
[View Screenshots](#screenshots)

## 📖 Table of Contents
1. [🎯 Rest API](#rest-api)  
2. [📝 Info and Pagination](#info-and-pagination)  
3. [⚙️ API Reference](#api-reference)  
4. [🖼️ Screenshots](#screenshots)  
5. [🤝 Contributing](#contributing)  
6. [📩 Contact](#contact)

## Rest API
- Base url: https://rickandmortyapi.com/api
- The base url contains information about all available API's resources. All requests are `GET` requests and go over `https`. All responses will return data in `json`.

## Info and Pagination
- The API will automatically paginate the responses. You will receive up to 20 documents per page.
- Each resource contains an `info` object with information about the response.

| Key | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `count` | `string` | The length of the response |
| `pages` | `string` | The amount of pages|
| `next` | `string` | Link to the next page (if it exists)|
| `prev` | `string` | Link to the previous page (if it exists)|

## API Reference

#### Get character

```https
GET https://rickandmortyapi.com/api/character/
```

| Path | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `/character` | `string` | Fetchs first 20 characters |

#### Filter & Search Character

```https
GET https://rickandmortyapi.com/api/character/?name=rick&status=alive
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `name`      | `string` | character's name e.g. rick, morty|
| `status`      | `string` |  character's status e.g. alive, dead|
| `species`      | `string` |  character's species e.g. alien, human |
| `gender` | `string` |  character's gender e.g. female, male |

#### Get Locations

```https
GET https://rickandmortyapi.com/api/location
```

| Path | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `/location`      | `string` | Fetchs first 20 locations |


#### Filter & Search Locations

```https
GET https://rickandmortyapi.com/api/location/?name=earth&type=planet
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `/name`      | `string` | Location's name e.g. Abadango, Nuptia|
| `/type`      | `string` | Location's type e.g. earth, dream|


#### Get Episodes

```https
GET https://rickandmortyapi.com/api/episode
```


| Path | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `/epsiode` | `string` | Fetchs first 20 episodes |


#### Filter & Search Episodes

```https
GET https://rickandmortyapi.com/api/episode/28
```
| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `/(episodeNumber)` | `string` | Episode number to get episode|
| `/name`      | `string` | Epiosde's name e.g. Anatomy Park|

<a name="screenshots-section"></a>
## Screenshots 
### Filter
<img src="../Rickipedia/Screenshots/Characters.PNG" alt="drawing" width="200"/> 
<img src="../Rickipedia/Screenshots/Filter.PNG" alt="drawing" width="200"/> 

### Sort
<img src="../Rickipedia/Screenshots/Sort.PNG" alt="drawing" width="200"/> 
<img src="../Rickipedia/Screenshots/Sort-2.PNG" alt="drawing" width="200"/>  

### Search
<img src="../Rickipedia/Screenshots/Search.PNG" alt="drawing" width="200"/> 
<img src="../Rickipedia/Screenshots/Search-2.PNG" alt="drawing" width="200"/> 
<img src="../Rickipedia/Screenshots/Search-3.PNG" alt="drawing" width="200"/> 
<img src="../Rickipedia/Screenshots/Search-4.PNG" alt="drawing" width="200"/> 

## Contributing

1. Fork the repo
2. `git checkout -b feature/YourFeature`
3. `git commit -m "Add YourFeature"`
4. `git push origin feature/YourFeature`
5. Open a pull request
  
## Contact

**Doris Wen** (iOS Developer)
- ✉️ [doris070714@gmail.com](mailto:doris070714@gmail.com)
- Instagram: [dolores_dione](https://www.instagram.com/dolores_dione/)