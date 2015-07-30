clc
clear all
close all

%% Parameter
test_freq = 19 ; % relative ratio to N
test_freq_range = [ 17 ];
N = 64;
Q = 2^4 ;
fvtoolAnalysis = 'magnitude' ; % 'polezero', 'freq', 'magnitude', 'phase'
RANGE_TEST = false;

if ~RANGE_TEST
    test_freq_range = test_freq ;
end

%% test 1 :  single pole goertzel filter

cell_idx = 1 ;
for k = test_freq_range
    a{cell_idx} = [1 -exp(1i*2*pi*k/N)] ;
    b{cell_idx} = [1] ;
    
    a{cell_idx} = floor( a{ cell_idx}*Q) / Q ;
    b{cell_idx} = floor( b{ cell_idx}*Q) / Q ;
    cell_idx = cell_idx + 1 ;
end

c = reshape( [b; a], [], 1) ;
[ a, b] = deal({});
fvtool( c{:}, 'Analysis', fvtoolAnalysis  )

%% test 2 :  pole pair and single zero goertzel filter
cell_idx = 1 ;
for k = test_freq_range
    a{cell_idx} = [1 -2*cos(2*pi*k/N) 1] ;
    b{cell_idx} = [1 -exp(1i*2*pi*k/N)] ;
    
    a{cell_idx} = floor( a{ cell_idx}*Q) / Q ;
    b{cell_idx} = floor( b{ cell_idx}*Q) / Q ;
    cell_idx = cell_idx + 1 ;
end

c = reshape( [b; a], [], 1) ;
[ a, b] = deal({});
fvtool( c{:}, 'Analysis', fvtoolAnalysis )

%% test 3 :   pole pair and  around zeros goertzel filter, DFT bins
cell_idx = 1 ;
for k = test_freq_range
    a{cell_idx} = [1 -2*cos(2*pi*k/N) 1] ;
    b{cell_idx} = [1 zeros(1, N-1)  -1] ;
    
    a{cell_idx} = floor( a{ cell_idx}*Q) / Q ;
    b{cell_idx} = floor( b{ cell_idx}*Q) / Q ;
    cell_idx = cell_idx + 1 ;
end

c = reshape( [b; a], [], 1) ;
[ a, b] = deal({});
fvtool( c{:}, 'Analysis', fvtoolAnalysis  )