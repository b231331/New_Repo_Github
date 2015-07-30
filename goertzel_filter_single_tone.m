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

%% test 2 :  pole pair and single zero goertzel filter
cell_idx = 1 ;
for k = test_freq_range
    a{cell_idx} = [1 -2*cos(2*pi*k/N) 1] ;
    b{cell_idx} = [1 -exp(1i*2*pi*k/N)] ;
    
    a{cell_idx} = floor( a{ cell_idx}*Q) / Q ;
		
%     b{cell_idx}(2) = -exp(1i* acos( a{cell_idx}(2)/(-2)) );
    b{cell_idx} = floor( b{ cell_idx}*Q) / Q ;
    
    input_w_quant( cell_idx) = acos( a{cell_idx}(2)/(-2) );
    input_w( cell_idx) = 2*pi*k/N ;
    
    
    input_w_quant_floating = cos( input_w_quant(cell_idx)* (0 : 8*N-1) ) ;
%     input_w_floating = cos( input_w(cell_idx)* (0 : 8*N-1) ) ;
input_w_floating = randn( 1, 20*N) + 1i*randn(1, 20*N);

    y_quant = filter( b{cell_idx}, a{cell_idx}, input_w_quant_floating ) ;
    y = filter( b{cell_idx}, a{cell_idx}, input_w_floating ) ;
    complx = @(x) [ real(x(:)) imag(x(:)) ] ;
    
    subplot(411)
    plot(input_w_quant_floating, '.-')
    subplot(412)
    plot( complx(y_quant), '.-' )
    subplot(413)
    plot(input_w_floating, '.-')
    subplot(414)
    plot( complx(y), '.-' )
    
    fvtool(y)
    
    cell_idx = cell_idx + 1 ;
%     pause
end





%% test 3 :   pole pair and  around zeros goertzel filter, DFT bins
% cell_idx = 1 ;
% for k = test_freq_range
%     a{cell_idx} = [1 -2*cos(2*pi*k/N) 1] ;
%     b{cell_idx} = [1 zeros(1, N-1)  -1] ;
%     
%     a{cell_idx} = floor( a{ cell_idx}*Q) / Q ;
%     b{cell_idx} = floor( b{ cell_idx}*Q) / Q ;
%     cell_idx = cell_idx + 1 ;
% end

