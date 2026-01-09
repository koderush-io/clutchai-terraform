-- MaData Marketing Intelligence Hub - Database Schema
-- This script creates the core database tables for the MaData platform

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Marketing Campaigns Table
CREATE TABLE IF NOT EXISTS marketing_campaigns (
    id SERIAL PRIMARY KEY,
    campaign_uuid UUID DEFAULT uuid_generate_v4(),
    campaign_name VARCHAR(255) NOT NULL,
    campaign_type VARCHAR(100) NOT NULL, -- paid, organic, influencer, ooh, email, sms
    budget DECIMAL(15,2),
    start_date DATE NOT NULL,
    end_date DATE,
    objectives JSONB,
    target_audience JSONB,
    channels JSONB,
    status VARCHAR(50) DEFAULT 'active', -- active, paused, completed, cancelled
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Sales Data Table
CREATE TABLE IF NOT EXISTS sales_data (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    revenue DECIMAL(15,2),
    units_sold INTEGER,
    channel VARCHAR(100),
    customer_type VARCHAR(50), -- new, repeat, returning
    geography VARCHAR(100),
    product_category VARCHAR(100),
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Contextual Data Table
CREATE TABLE IF NOT EXISTS contextual_data (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    data_type VARCHAR(100) NOT NULL, -- competitor, weather, economic, social, political
    source VARCHAR(255),
    data JSONB,
    geography VARCHAR(100),
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Attribution Events Table
CREATE TABLE IF NOT EXISTS attribution_events (
    id SERIAL PRIMARY KEY,
    event_uuid UUID DEFAULT uuid_generate_v4(),
    customer_id VARCHAR(255),
    event_type VARCHAR(100) NOT NULL, -- view, click, purchase, signup, download
    campaign_id INTEGER REFERENCES marketing_campaigns(id),
    channel VARCHAR(100),
    touchpoint_order INTEGER,
    timestamp TIMESTAMP NOT NULL,
    value DECIMAL(15,2),
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Marketing Channels Table
CREATE TABLE IF NOT EXISTS marketing_channels (
    id SERIAL PRIMARY KEY,
    channel_name VARCHAR(100) NOT NULL,
    channel_type VARCHAR(50) NOT NULL, -- digital, offline, hybrid
    description TEXT,
    cost_per_impression DECIMAL(10,4),
    cost_per_click DECIMAL(10,4),
    cost_per_acquisition DECIMAL(10,2),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Campaign Performance Table
CREATE TABLE IF NOT EXISTS campaign_performance (
    id SERIAL PRIMARY KEY,
    campaign_id INTEGER REFERENCES marketing_campaigns(id),
    date DATE NOT NULL,
    impressions BIGINT,
    clicks BIGINT,
    conversions BIGINT,
    spend DECIMAL(15,2),
    revenue DECIMAL(15,2),
    roas DECIMAL(10,4),
    ctr DECIMAL(10,4),
    conversion_rate DECIMAL(10,4),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Competitive Intelligence Table
CREATE TABLE IF NOT EXISTS competitive_intelligence (
    id SERIAL PRIMARY KEY,
    competitor_name VARCHAR(255) NOT NULL,
    data_type VARCHAR(100) NOT NULL, -- pricing, promotion, campaign, product
    data JSONB,
    source VARCHAR(255),
    date DATE NOT NULL,
    geography VARCHAR(100),
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Marketing Mix Model Results Table
CREATE TABLE IF NOT EXISTS mmm_results (
    id SERIAL PRIMARY KEY,
    model_version VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    channel VARCHAR(100) NOT NULL,
    contribution DECIMAL(10,4),
    elasticity DECIMAL(10,4),
    saturation_level DECIMAL(10,4),
    carryover_effect DECIMAL(10,4),
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Attribution Models Table
CREATE TABLE IF NOT EXISTS attribution_models (
    id SERIAL PRIMARY KEY,
    model_name VARCHAR(255) NOT NULL,
    model_type VARCHAR(100) NOT NULL, -- first_touch, last_touch, linear, time_decay, shapley
    parameters JSONB,
    accuracy_score DECIMAL(10,4),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Attribution Results Table
CREATE TABLE IF NOT EXISTS attribution_results (
    id SERIAL PRIMARY KEY,
    attribution_model_id INTEGER REFERENCES attribution_models(id),
    campaign_id INTEGER REFERENCES marketing_campaigns(id),
    channel VARCHAR(100),
    attribution_value DECIMAL(15,2),
    attribution_percentage DECIMAL(10,4),
    date DATE NOT NULL,
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Forecasting Results Table
CREATE TABLE IF NOT EXISTS forecasting_results (
    id SERIAL PRIMARY KEY,
    forecast_type VARCHAR(100) NOT NULL, -- sales, roi, budget
    forecast_date DATE NOT NULL,
    predicted_value DECIMAL(15,2),
    confidence_interval_lower DECIMAL(15,2),
    confidence_interval_upper DECIMAL(15,2),
    model_version VARCHAR(50),
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Client Configuration Table
CREATE TABLE IF NOT EXISTS client_config (
    id SERIAL PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    industry VARCHAR(100),
    geography VARCHAR(100),
    timezone VARCHAR(50),
    currency VARCHAR(10) DEFAULT 'USD',
    data_retention_days INTEGER DEFAULT 365,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Data Sources Table
CREATE TABLE IF NOT EXISTS data_sources (
    id SERIAL PRIMARY KEY,
    source_name VARCHAR(255) NOT NULL,
    source_type VARCHAR(100) NOT NULL, -- api, file, database, manual
    connection_config JSONB,
    is_active BOOLEAN DEFAULT true,
    last_sync TIMESTAMP,
    sync_frequency VARCHAR(50), -- hourly, daily, weekly, monthly
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Alerts and Notifications Table
CREATE TABLE IF NOT EXISTS alerts (
    id SERIAL PRIMARY KEY,
    alert_type VARCHAR(100) NOT NULL, -- performance, budget, anomaly, competitive
    severity VARCHAR(50) NOT NULL, -- low, medium, high, critical
    title VARCHAR(255) NOT NULL,
    description TEXT,
    threshold_value DECIMAL(15,2),
    current_value DECIMAL(15,2),
    status VARCHAR(50) DEFAULT 'active', -- active, acknowledged, resolved
    client_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    acknowledged_at TIMESTAMP,
    resolved_at TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_marketing_campaigns_client_id ON marketing_campaigns(client_id);
CREATE INDEX IF NOT EXISTS idx_marketing_campaigns_date_range ON marketing_campaigns(start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_sales_data_date ON sales_data(date);
CREATE INDEX IF NOT EXISTS idx_sales_data_client_id ON sales_data(client_id);
CREATE INDEX IF NOT EXISTS idx_attribution_events_campaign_id ON attribution_events(campaign_id);
CREATE INDEX IF NOT EXISTS idx_attribution_events_timestamp ON attribution_events(timestamp);
CREATE INDEX IF NOT EXISTS idx_campaign_performance_campaign_date ON campaign_performance(campaign_id, date);
CREATE INDEX IF NOT EXISTS idx_competitive_intelligence_date ON competitive_intelligence(date);
CREATE INDEX IF NOT EXISTS idx_mmm_results_date ON mmm_results(date);
CREATE INDEX IF NOT EXISTS idx_attribution_results_date ON attribution_results(date);
CREATE INDEX IF NOT EXISTS idx_forecasting_results_date ON forecasting_results(forecast_date);
CREATE INDEX IF NOT EXISTS idx_alerts_client_status ON alerts(client_id, status);

-- Create triggers for updated_at timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_marketing_campaigns_updated_at BEFORE UPDATE ON marketing_campaigns FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_marketing_channels_updated_at BEFORE UPDATE ON marketing_channels FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_attribution_models_updated_at BEFORE UPDATE ON attribution_models FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_client_config_updated_at BEFORE UPDATE ON client_config FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_data_sources_updated_at BEFORE UPDATE ON data_sources FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Insert default marketing channels
INSERT INTO marketing_channels (channel_name, channel_type, description) VALUES
('Google Ads', 'digital', 'Google Search and Display advertising'),
('Facebook Ads', 'digital', 'Facebook and Instagram advertising'),
('LinkedIn Ads', 'digital', 'LinkedIn professional advertising'),
('Twitter Ads', 'digital', 'Twitter advertising'),
('TikTok Ads', 'digital', 'TikTok advertising'),
('Email Marketing', 'digital', 'Email campaigns and newsletters'),
('SMS Marketing', 'digital', 'SMS campaigns'),
('Influencer Marketing', 'hybrid', 'Social media influencer partnerships'),
('Out-of-Home (OOH)', 'offline', 'Billboards, transit, and outdoor advertising'),
('Radio', 'offline', 'Radio advertising'),
('TV', 'offline', 'Television advertising'),
('Print', 'offline', 'Newspaper and magazine advertising'),
('Events', 'offline', 'Trade shows, conferences, and sponsored events'),
('Organic Social', 'digital', 'Organic social media content'),
('SEO', 'digital', 'Search engine optimization'),
('Content Marketing', 'digital', 'Blog posts, articles, and content creation')
ON CONFLICT DO NOTHING;

-- Insert default attribution models
INSERT INTO attribution_models (model_name, model_type, parameters) VALUES
('First Touch Attribution', 'first_touch', '{"description": "Gives 100% credit to the first touchpoint"}'),
('Last Touch Attribution', 'last_touch', '{"description": "Gives 100% credit to the last touchpoint"}'),
('Linear Attribution', 'linear', '{"description": "Distributes credit equally across all touchpoints"}'),
('Time Decay Attribution', 'time_decay', '{"decay_factor": 0.5, "description": "Gives more credit to recent touchpoints"}'),
('Shapley Value Attribution', 'shapley', '{"description": "Uses game theory to fairly distribute credit"}'),
('Markov Chain Attribution', 'markov', '{"description": "Uses Markov chains to model customer journey"}')
ON CONFLICT DO NOTHING;

-- Insert default client configuration
INSERT INTO client_config (client_name, industry, geography, timezone, currency) VALUES
('MaData Demo Client', 'Technology', 'Africa', 'Africa/Lagos', 'USD')
ON CONFLICT DO NOTHING;

COMMIT;
