<Query Kind="Statements">
  <Connection>
    <ID>43c68604-e9b2-416f-81d4-94e9c2267db1</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>Chinook</Database>
  </Connection>
</Query>

int minyear = 1970;
int maxyear = 1979;
var results = 

from x in Albums
where x.ReleaseYear >= minyear && x.ReleaseYear <= maxyear
orderby x.ReleaseYear, x.Title
select x;

results.Dump();
