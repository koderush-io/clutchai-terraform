-- MaData Marketing Intelligence Hub - Mock Data
-- This script populates the MaData tables with realistic mock data for testing and demonstration

-- Insert mock marketing campaigns
INSERT INTO marketing_campaigns (campaign_name, campaign_type, budget, start_date, end_date, objectives, target_audience, channels, status, client_id) VALUES
('Summer Sale 2024', 'paid', 50000.00, '2024-06-01', '2024-08-31', '{"goal": "increase_sales", "target": "25%", "kpi": "revenue"}', '{"age": "25-45", "location": "Nigeria", "interests": ["fashion", "electronics"]}', '{"google_ads": true, "facebook_ads": true, "instagram_ads": true}', 'active', 1),
('Back to School Campaign', 'paid', 30000.00, '2024-08-15', '2024-09-30', '{"goal": "student_acquisition", "target": "15%", "kpi": "new_customers"}', '{"age": "18-25", "location": "Kenya", "interests": ["education", "technology"]}', '{"google_ads": true, "tiktok_ads": true}', 'active', 1),
('Holiday Shopping 2024', 'paid', 75000.00, '2024-11-01', '2024-12-31', '{"goal": "holiday_sales", "target": "40%", "kpi": "revenue"}', '{"age": "25-55", "location": "South Africa", "interests": ["gifts", "shopping"]}', '{"google_ads": true, "facebook_ads": true, "email_marketing": true}', 'draft', 1),
('Brand Awareness Q1', 'organic', 20000.00, '2024-01-01', '2024-03-31', '{"goal": "brand_awareness", "target": "30%", "kpi": "reach"}', '{"age": "18-45", "location": "Ghana", "interests": ["lifestyle", "technology"]}', '{"organic_social": true, "content_marketing": true}', 'completed', 1),
('Influencer Partnership', 'influencer', 15000.00, '2024-07-01', '2024-07-31', '{"goal": "engagement", "target": "50%", "kpi": "engagement_rate"}', '{"age": "20-35", "location": "Nigeria", "interests": ["fashion", "beauty"]}', '{"influencer_marketing": true, "instagram_ads": true}', 'completed', 1);

-- Insert mock sales data
INSERT INTO sales_data (date, revenue, units_sold, channel, customer_type, geography, product_category, client_id) VALUES
('2024-01-01', 15000.00, 150, 'google_ads', 'new', 'Nigeria', 'Electronics', 1),
('2024-01-02', 18000.00, 180, 'facebook_ads', 'repeat', 'Kenya', 'Fashion', 1),
('2024-01-03', 12000.00, 120, 'organic_social', 'new', 'South Africa', 'Home & Garden', 1),
('2024-01-04', 22000.00, 220, 'google_ads', 'repeat', 'Ghana', 'Electronics', 1),
('2024-01-05', 16000.00, 160, 'email_marketing', 'returning', 'Nigeria', 'Fashion', 1),
('2024-01-06', 19000.00, 190, 'facebook_ads', 'new', 'Kenya', 'Electronics', 1),
('2024-01-07', 14000.00, 140, 'influencer_marketing', 'new', 'South Africa', 'Beauty', 1),
('2024-01-08', 25000.00, 250, 'google_ads', 'repeat', 'Ghana', 'Electronics', 1),
('2024-01-09', 17000.00, 170, 'tiktok_ads', 'new', 'Nigeria', 'Fashion', 1),
('2024-01-10', 21000.00, 210, 'facebook_ads', 'repeat', 'Kenya', 'Home & Garden', 1);

-- Insert mock contextual data
INSERT INTO contextual_data (date, data_type, source, data, geography, client_id) VALUES
('2024-01-01', 'competitor', 'web_scraping', '{"competitor": "Competitor A", "price_change": "5%", "promotion": "summer_sale"}', 'Nigeria', 1),
('2024-01-01', 'weather', 'weather_api', '{"temperature": 28, "humidity": 65, "condition": "sunny"}', 'Nigeria', 1),
('2024-01-01', 'economic', 'central_bank', '{"inflation_rate": 12.5, "interest_rate": 18.5, "gdp_growth": 2.1}', 'Nigeria', 1),
('2024-01-02', 'social', 'social_media', '{"trending_topics": ["summer_fashion", "tech_reviews"], "sentiment": "positive"}', 'Kenya', 1),
('2024-01-02', 'political', 'news_api', '{"election_impact": "low", "policy_changes": "none", "stability": "high"}', 'Kenya', 1),
('2024-01-03', 'seasonal', 'calendar', '{"season": "summer", "holiday": "none", "shopping_period": "normal"}', 'South Africa', 1),
('2024-01-03', 'competitor', 'web_scraping', '{"competitor": "Competitor B", "new_product": "smartphone", "launch_date": "2024-01-15"}', 'South Africa', 1);

-- Insert mock attribution events
INSERT INTO attribution_events (customer_id, event_type, campaign_id, channel, touchpoint_order, timestamp, value, client_id) VALUES
('CUST_001', 'view', 1, 'google_ads', 1, '2024-01-01 10:00:00', 0.00, 1),
('CUST_001', 'click', 1, 'google_ads', 2, '2024-01-01 10:05:00', 0.00, 1),
('CUST_001', 'purchase', 1, 'google_ads', 3, '2024-01-01 10:30:00', 150.00, 1),
('CUST_002', 'view', 1, 'facebook_ads', 1, '2024-01-01 11:00:00', 0.00, 1),
('CUST_002', 'click', 1, 'facebook_ads', 2, '2024-01-01 11:10:00', 0.00, 1),
('CUST_002', 'view', 1, 'email_marketing', 3, '2024-01-01 14:00:00', 0.00, 1),
('CUST_002', 'purchase', 1, 'email_marketing', 4, '2024-01-01 16:00:00', 200.00, 1),
('CUST_003', 'view', 2, 'tiktok_ads', 1, '2024-01-02 09:00:00', 0.00, 1),
('CUST_003', 'click', 2, 'tiktok_ads', 2, '2024-01-02 09:15:00', 0.00, 1),
('CUST_003', 'purchase', 2, 'tiktok_ads', 3, '2024-01-02 12:00:00', 100.00, 1);

-- Insert mock campaign performance data
INSERT INTO campaign_performance (campaign_id, date, impressions, clicks, conversions, spend, revenue, roas, ctr, conversion_rate) VALUES
(1, '2024-01-01', 10000, 500, 50, 1000.00, 5000.00, 5.00, 0.05, 0.10),
(1, '2024-01-02', 12000, 600, 60, 1200.00, 6000.00, 5.00, 0.05, 0.10),
(1, '2024-01-03', 15000, 750, 75, 1500.00, 7500.00, 5.00, 0.05, 0.10),
(2, '2024-01-01', 8000, 400, 40, 800.00, 4000.00, 5.00, 0.05, 0.10),
(2, '2024-01-02', 9000, 450, 45, 900.00, 4500.00, 5.00, 0.05, 0.10),
(2, '2024-01-03', 11000, 550, 55, 1100.00, 5500.00, 5.00, 0.05, 0.10);

-- Insert mock competitive intelligence data
INSERT INTO competitive_intelligence (competitor_name, data_type, data, source, date, geography, client_id) VALUES
('Competitor A', 'pricing', '{"product": "smartphone", "old_price": 500, "new_price": 450, "reduction": "10%"}', 'web_scraping', '2024-01-01', 'Nigeria', 1),
('Competitor A', 'promotion', '{"campaign": "summer_sale", "discount": "20%", "duration": "30_days"}', 'social_media', '2024-01-01', 'Nigeria', 1),
('Competitor B', 'campaign', '{"type": "influencer", "platform": "instagram", "reach": "100k", "engagement": "5%"}', 'social_media', '2024-01-02', 'Kenya', 1),
('Competitor B', 'product', '{"launch": "new_feature", "category": "electronics", "announcement_date": "2024-01-15"}', 'press_release', '2024-01-02', 'Kenya', 1),
('Competitor C', 'pricing', '{"product": "laptop", "old_price": 1000, "new_price": 950, "reduction": "5%"}', 'web_scraping', '2024-01-03', 'South Africa', 1);

-- Insert mock MMM results
INSERT INTO mmm_results (model_version, date, channel, contribution, elasticity, saturation_level, carryover_effect, client_id) VALUES
('v1.0', '2024-01-01', 'google_ads', 0.35, 0.15, 0.80, 0.30, 1),
('v1.0', '2024-01-01', 'facebook_ads', 0.25, 0.12, 0.75, 0.25, 1),
('v1.0', '2024-01-01', 'email_marketing', 0.20, 0.18, 0.85, 0.20, 1),
('v1.0', '2024-01-01', 'organic_social', 0.15, 0.10, 0.70, 0.15, 1),
('v1.0', '2024-01-01', 'influencer_marketing', 0.05, 0.08, 0.60, 0.10, 1);

-- Insert mock attribution results
INSERT INTO attribution_results (attribution_model_id, campaign_id, channel, attribution_value, attribution_percentage, date, client_id) VALUES
(1, 1, 'google_ads', 17500.00, 35.0, '2024-01-01', 1),
(1, 1, 'facebook_ads', 12500.00, 25.0, '2024-01-01', 1),
(1, 1, 'email_marketing', 10000.00, 20.0, '2024-01-01', 1),
(1, 1, 'organic_social', 7500.00, 15.0, '2024-01-01', 1),
(1, 1, 'influencer_marketing', 2500.00, 5.0, '2024-01-01', 1);

-- Insert mock forecasting results
INSERT INTO forecasting_results (forecast_type, forecast_date, predicted_value, confidence_interval_lower, confidence_interval_upper, model_version, client_id) VALUES
('sales', '2024-01-11', 20000.00, 16000.00, 24000.00, 'v1.0', 1),
('sales', '2024-01-12', 21000.00, 16800.00, 25200.00, 'v1.0', 1),
('sales', '2024-01-13', 22000.00, 17600.00, 26400.00, 'v1.0', 1),
('roi', '2024-01-11', 3.5, 2.8, 4.2, 'v1.0', 1),
('roi', '2024-01-12', 3.6, 2.9, 4.3, 'v1.0', 1),
('roi', '2024-01-13', 3.7, 3.0, 4.4, 'v1.0', 1);

-- Insert mock alerts
INSERT INTO alerts (alert_type, severity, title, description, threshold_value, current_value, status, client_id) VALUES
('performance', 'medium', 'Campaign Performance Drop', 'Google Ads campaign showing 20% decrease in CTR over the last 3 days', 0.05, 0.04, 'active', 1),
('budget', 'high', 'Budget Exhaustion Warning', 'Facebook Ads campaign will exhaust budget in 2 days at current spend rate', 1000.00, 950.00, 'active', 1),
('anomaly', 'low', 'Unusual Traffic Pattern', 'Organic social traffic increased by 150% compared to last week', 1000, 2500, 'active', 1),
('competitive', 'medium', 'Competitor Price Reduction', 'Competitor A reduced smartphone prices by 10%', 500.00, 450.00, 'acknowledged', 1);

-- Insert mock client configuration
INSERT INTO client_config (client_name, industry, geography, timezone, currency, data_retention_days, is_active) VALUES
('MaData Demo Client', 'E-commerce', 'Africa', 'Africa/Lagos', 'USD', 365, true),
('Tech Startup Kenya', 'Technology', 'Kenya', 'Africa/Nairobi', 'KES', 180, true),
('Fashion Brand SA', 'Fashion', 'South Africa', 'Africa/Johannesburg', 'ZAR', 365, true);

-- Insert mock data sources
INSERT INTO data_sources (source_name, source_type, connection_config, is_active, last_sync, sync_frequency) VALUES
('Google Ads API', 'api', '{"api_key": "mock_key", "customer_id": "1234567890"}', true, '2024-01-01 12:00:00', 'daily'),
('Facebook Marketing API', 'api', '{"access_token": "mock_token", "ad_account_id": "act_123456789"}', true, '2024-01-01 12:00:00', 'daily'),
('Salesforce CRM', 'api', '{"username": "mock_user", "password": "mock_pass", "security_token": "mock_token"}', true, '2024-01-01 12:00:00', 'daily'),
('Weather API', 'api', '{"api_key": "mock_weather_key", "base_url": "https://api.weather.com"}', true, '2024-01-01 12:00:00', 'hourly'),
('Social Media Scraper', 'web_scraping', '{"targets": ["twitter", "instagram", "facebook"], "keywords": ["competitor", "brand"]}', true, '2024-01-01 12:00:00', 'daily');

COMMIT;
