//+------------------------------------------------------------------+
//|                                     Ratio to profit of funds.mq4 |
//|                                 Copyright 2017, Keisuke Iwabuchi |
//|                                        https://order-button.com/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Keisuke Iwabuchi"
#property link      "https://order-button.com/"
#property version   "1.00"
#property strict
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 clrRed
#property indicator_width1 1
#property indicator_style1 0


input double MAX = 1.0;
input double MIN = -1.0;


double value[];


int OnInit()
{
   IndicatorBuffers(1);
   SetIndexStyle(0, DRAW_HISTOGRAM);
   SetIndexBuffer(0, value);
   IndicatorDigits(Digits);
   
   IndicatorSetDouble(INDICATOR_MAXIMUM, MAX);
   IndicatorSetDouble(INDICATOR_MINIMUM, MIN);
   
   return(INIT_SUCCEEDED);
}


int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   double balance, profit;
   int limit = Bars - IndicatorCounted();
   
   for(int i = limit - 1; i >= 0; i--){
      balance = AccountBalance();
      profit = AccountProfit();
      
      if(profit != 0) {
         value[i] = profit / balance * 100;
      }
      else {
         value[i] = 0;
      }
   }

   return(rates_total);
}

