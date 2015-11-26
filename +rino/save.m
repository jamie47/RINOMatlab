function [ output_args ] = save( matrix, datatype, varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%DON'T USE '\' IN ANY DATA - NEED TO FIX THIS WORKAROUND

%need more error checks e.g. imaginary matrices.
if ischar(datatype)~=1
    error('Data type must be a string.')
end

nVarargs = length(varargin);
if nVarargs>0
    tags='Other tag no one will use skldfjhaslf';
    for VarargIndex = 1:nVarargs
        if isstr(varargin{VarargIndex})~=1
        error('Tags must be strings.')
        end
        if VarargIndex<nVarargs
            tags=strcat(tags,varargin{VarargIndex},'Spacer that no one should use lakshfgalshf');
        else
             tags=strcat(tags,varargin{VarargIndex},'Second spacer no one should use kjrfgerlgh',']');
        end
    end
else 
    tags='';
end
    
    
time=char(datetime('now','format','yyyy-MM-dd''T''HH:mm:ss.ms''Z'));

%tags=tags(4:end-1);
%jsondatastruct=struct('json_field',matrix,'class_name',datatype,'time',time,'tags',tags);
jsondatastruct=struct('json_field',matrix,'class_name',datatype,'tags',tags);
jsondata=regexprep(rino.dump(jsondatastruct),'Spacer that no one should use lakshfgalshf','", "');
jsondata=regexprep(jsondata,'Second spacer no one should use kjrfgerlgh]"','"]');
jsondata=regexprep(jsondata,'"Other tag no one will use skldfjhaslf','["');

%regexprep(jsondata,'\','')


%jsondata=struct('data',matrix,'datatype',datatype,'time',time,'tags',varargin);

%output_args=jsondata;
output_args=rino.dump(struct('json_field',matrix,'class_name',datatype));
end


