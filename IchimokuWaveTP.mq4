// Ichimoku Wave Indicator
input int TenkanPeriod = 9;  // Tenkan-sen period
input int KijunPeriod = 26;   // Kijun-sen period
input int SenkouSpanBPeriod = 52; // Senkou Span B period
input double TPFactor = 1.5; // Factor to calculate TP

double Tenkan, Kijun, SenkouA, SenkouB, Chikou;

// Function to calculate Ichimoku values
void CalculateIchimoku()
{
    Tenkan = (iHigh(NULL, 0, TenkanPeriod) + iLow(NULL, 0, TenkanPeriod)) / 2;
    Kijun = (iHigh(NULL, 0, KijunPeriod) + iLow(NULL, 0, KijunPeriod)) / 2;
    SenkouA = (Tenkan + Kijun) / 2;
    SenkouB = (iHigh(NULL, 0, SenkouSpanBPeriod) + iLow(NULL, 0, SenkouSpanBPeriod)) / 2;
    Chikou = iClose(NULL, 0, 26; // 26 periods back
}

// OnCalculate function to draw waves and TP
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
    CalculateIchimoku();
    
    // Determine the trend
    double lastClose = iClose(NULL, 0, 0);
    double lastHigh = iHigh(NULL, 0, 1);
    double lastLow = iLow(NULL, 0, 1);
    
    if (lastClose > Kijun) // Bullish Trend
    {
        // Calculate TP
        double tpPrice = lastHigh + (lastHigh - lastLow) * TPFactor;
        Alert("Bullish Trend - TP at: ", tpPrice);
        
        // Draw the wave
        ObjectCreate(0, "BullishWave", OBJ_TREND, 0, time[1], lastLow, time[0], tpPrice);
    }
    else if (lastClose < Kijun) // Bearish Trend
    {
        // Calculate TP
        double tpPrice = lastLow - (lastHigh - lastLow) * TPFactor;
        Alert("Bearish Trend - TP at: ", tpPrice);
        
        // Draw the wave
        ObjectCreate(0, "BearishWave", OBJ_TREND, 0, time[1], lastHigh, time[0], tpPrice);
    }
    
    return rates_total;
}
