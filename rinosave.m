function [ output ] = rinosave(dataobject,class_name ,varargin )
%UNTITLED2 Summary of this function goes here
%   Function takes a dataobject (list or matrix etc.) and a class name.
%   There are two optional input parameters:
%   tags: specify by using the input 'tags' followed by a cell array
%   containing the desired tags as strings
%   ParamValuePairs: specify by using the input 'ParamValuePairs' followed by a cell array
%   containing the desired fields and values in a structure array of the
%   form {param1, value1, param2, value 2, ...}

%Problems - need to add notes field, need to include ability to have spaces
%in param names, need to check input data type and throw error if needed,
%create more fn for API token, find a more elegant way of writing tags.

%USE DIFFERENT JSON PARSER THAT ALLOWS CODING/DECODING OF CELL ARRAYS








%INCLUDE CHECK FOR RIGHT MATRIX TYPE ETC.

if ischar(class_name)~=1
    error('Class name must be a string.')
end

p = inputParser;
%Additional field, value pairs as and even numbered cell array with of the
%form {param1,value1, param2, value2} - CANT USE SPACES IN NAME VALUE PAIRS
%- CORRECT THIS
addParamValue(p,'ParamValuePairs','',@(x) (iscell(x) && (sum(cellfun(@isstr,x))==length(x))) && (mod(length(x),2)==0) );


%Input a tag as a string or tags as a cell aray of stings in the form
%"'tags',{'tag1','tag2'}". Function check that input is a string or a cell
%array containing only strings
%TO DO - GIVE CLEAR ERROR MESSAGE WHEN USER USES INCORRECT INPUT - MAYBE
%CONVERT NUMERIC INPUT TO STRINGS AUTOMATICALLY.
addParamValue(p,'tags','',@(x) ischar(x) || (iscell(x) && (sum(cellfun(@ischar,x))==length(x))));
p.parse(varargin{:});
output=p.Results;


%Create string for tags
nTags = length(output.tags);
if nTags>0
    tags='Other tag no one will use skldfjhaslf';
    for TagIndex = 1:nTags
        if TagIndex<nTags
                tags=strcat(tags,output.tags{TagIndex},'Spacer that no one should use lakshfgalshf');
        else
                tags=strcat(tags,output.tags{TagIndex},'Second spacer no one should use kjrfgerlgh',']');
        end
    end
    tagsstruct=struct('tags',tags);
else
tagsstruct=struct();
end

%If extra ParamValuePairs were used, create a struct containing them
FieldsStruct=struct();
nParamValuePairs=length(output.ParamValuePairs);
if nParamValuePairs>0
   for t=1:(nParamValuePairs/2)
       TemporaryStruct=struct(output.ParamValuePairs{2*t-1},output.ParamValuePairs{2*t});
       FieldsStruct=catstruct(FieldsStruct,TemporaryStruct);
   end
end

%Combine everything into one data struct
jsondatastruct=catstruct(struct('data',dataobject,'class_name',class_name),FieldsStruct,tagsstruct);
%Convert to JSON
jsondata=regexprep(rino.dump(jsondatastruct),'Spacer that no one should use lakshfgalshf','", "');
%Parse to get tags in desired form
jsondata=regexprep(jsondata,'Second spacer no one should use kjrfgerlgh]"','"]');
jsondata=regexprep(jsondata,'"Other tag no one will use skldfjhaslf','["');

%Set API Token - look at either a way of auto-setting this on download or
%just package it up in a separate function so users can easily change it
%themselves
APIToken='Token 92434b916bea1b5de711c97bc333983fdb561929';
%create headers for HTTP Request
headers = [http_createHeader('Host','api.rinocloud.com'),http_createHeader('Authorization',APIToken),http_createHeader('Content-Type','application/json'),http_createHeader('Accept','application/json')];
response=urlread2('http://www.rinocloud.com/api/1/objects/','POST',jsondata,headers);
output=response;
end
