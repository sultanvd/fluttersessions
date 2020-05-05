import 'dart:collection';
import 'dart:io';

const String FILENAME = 'file.txt';
Map<int, List<String>> wordLineMap = HashMap();
Map<int, int> maxWordsLines = {};

void main() {
   readFile();
}


void readFile(){
    File(FILENAME).readAsString().then((String contents) {
      var lines = getLinesFromText(contents);
      findHighFrequencyInEachLine(lines);
      printResults();
    });
}


List<String> getLinesFromText(String text){
  return text.split('\n');
}

void findHighFrequencyInEachLine(List<String> lines){
    for(var i=0; i<lines.length; i++){

        var wordCountMap = HashMap<String, int>();

        for(var word in lines[i].split(' ')){
          var count = 0; 
          
          if(wordCountMap.containsKey(word)){
            count = wordCountMap[word];
          }
          
          wordCountMap[word] = count + 1;
        }
      
      wordLineMap[i+1] = getHighestRepeatingWords(wordCountMap);
      maxWordsLines[i+1] = getMaxNumberInLine(wordCountMap);
    }
}

List<String> getHighestRepeatingWords(Map<String, int> map){
   var highCount = 0;
   for(var value in map.values){
      if(value > highCount){
        highCount = value;
      }
   }

   var list = <String>[];
   for(var key in map.keys){
     if(map[key] == highCount){
       list.add(key);
     }
   }

   return list;
}

int getMaxNumberInLine(Map map){
   var highCount = 0;
   for(var value in map.values){
      if(value > highCount){
        highCount = value;
      }
   }

    return highCount;
}

void printResults(){
  for(var key in wordLineMap.keys){
    print('${wordLineMap[key]} (appears in line ${key})');
  }

  print('lines ${getMaxLinesList()} contains highest number of repeating words');
 
}


List<int> getMaxLinesList(){
  var lineList = List<int>(); 
  var maxNumber = getMaxNumberInLine(maxWordsLines);
  for(var key in maxWordsLines.keys){
    if(maxWordsLines[key] == maxNumber){
      lineList.add(key);
    }
  }

  return lineList;
}