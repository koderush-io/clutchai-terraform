-- Script to create all missing critical tables
-- Run this script to proactively create all tables needed by the platform

-- ============================================================================
-- 1. EXPERIMENTS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS experiments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    description VARCHAR,
    status VARCHAR NOT NULL DEFAULT 'pending',
    parameters JSONB,
    metrics JSONB DEFAULT '[]',
    artifacts JSONB DEFAULT '[]',
    tags JSONB DEFAULT '[]',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id),
    hpo_config_id UUID,
    explainability_analysis_id UUID,
    pipeline_id UUID,
    pipeline_execution_id UUID
);

CREATE INDEX IF NOT EXISTS ix_experiments_name ON experiments(name);
CREATE INDEX IF NOT EXISTS ix_experiments_user_id ON experiments(user_id);
CREATE INDEX IF NOT EXISTS ix_experiments_status ON experiments(status);

-- ============================================================================
-- 2. MODEL_DEPLOYMENTS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS model_deployments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    model_id UUID NOT NULL REFERENCES model_registry(id),
    environment VARCHAR NOT NULL,
    status VARCHAR NOT NULL DEFAULT 'deploying',
    resources JSONB,
    scaling JSONB,
    endpoints JSONB,
    metrics JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id),
    experiment_id UUID REFERENCES experiments(id),
    pipeline_id UUID,
    pipeline_execution_id UUID
);

CREATE INDEX IF NOT EXISTS ix_model_deployments_model_id ON model_deployments(model_id);
CREATE INDEX IF NOT EXISTS ix_model_deployments_user_id ON model_deployments(user_id);
CREATE INDEX IF NOT EXISTS ix_model_deployments_status ON model_deployments(status);
CREATE INDEX IF NOT EXISTS ix_model_deployments_environment ON model_deployments(environment);

-- ============================================================================
-- 3. LLM_MODELS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS llm_models (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    version VARCHAR,
    description TEXT,
    provider VARCHAR NOT NULL,
    model_type VARCHAR,
    base_model VARCHAR,
    status VARCHAR,
    provider_config JSONB,
    model_parameters JSONB,
    context_length INTEGER,
    model_size_bytes BIGINT,
    performance_metrics JSONB,
    cost_per_token FLOAT,
    endpoint_url VARCHAR,
    api_key_required BOOLEAN DEFAULT TRUE,
    user_id INTEGER REFERENCES users(id),
    organization_id INTEGER REFERENCES organizations(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deployed_at TIMESTAMP
);

CREATE INDEX IF NOT EXISTS ix_llm_models_name ON llm_models(name);
CREATE INDEX IF NOT EXISTS ix_llm_models_provider ON llm_models(provider);
CREATE INDEX IF NOT EXISTS ix_llm_models_user_id ON llm_models(user_id);
CREATE INDEX IF NOT EXISTS ix_llm_models_organization_id ON llm_models(organization_id);

-- ============================================================================
-- 4. PROMPT_TEMPLATES TABLE
-- ============================================================================
-- Note: template_type uses VARCHAR instead of enum for simplicity
CREATE TABLE IF NOT EXISTS prompt_templates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    description TEXT,
    template_type VARCHAR NOT NULL,
    template_content TEXT NOT NULL,
    variables JSONB,
    model_id UUID REFERENCES llm_models(id),
    version VARCHAR DEFAULT '1.0.0',
    tags JSONB,
    is_public BOOLEAN DEFAULT FALSE,
    usage_count INTEGER DEFAULT 0,
    average_rating FLOAT,
    prompt_category VARCHAR(100),
    target_model VARCHAR(100),
    expected_response_format JSONB,
    quality_metrics JSONB,
    success_rate FLOAT,
    optimization_history JSONB,
    a_b_test_results JSONB,
    performance_benchmarks JSONB,
    validation_rules JSONB,
    required_variables JSONB,
    optional_variables JSONB,
    user_id INTEGER NOT NULL REFERENCES users(id),
    organization_id INTEGER REFERENCES organizations(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS ix_prompt_templates_name ON prompt_templates(name);
CREATE INDEX IF NOT EXISTS ix_prompt_templates_user_id ON prompt_templates(user_id);
CREATE INDEX IF NOT EXISTS ix_prompt_templates_organization_id ON prompt_templates(organization_id);
CREATE INDEX IF NOT EXISTS ix_prompt_templates_template_type ON prompt_templates(template_type);

-- ============================================================================
-- 5. FINE_TUNING_JOBS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS fine_tuning_jobs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    description TEXT,
    base_model VARCHAR NOT NULL,
    base_model_id UUID REFERENCES llm_models(id),
    provider VARCHAR NOT NULL,
    fine_tuned_model_id VARCHAR,
    training_data_path VARCHAR,
    training_data JSONB,
    validation_data_path VARCHAR,
    validation_data JSONB,
    dataset_id INTEGER,
    hyperparameters JSONB,
    config JSONB,
    status VARCHAR DEFAULT 'pending',
    progress FLOAT DEFAULT 0.0,
    error_message TEXT,
    metrics JSONB,
    training_loss FLOAT,
    validation_loss FLOAT,
    provider_job_id VARCHAR,
    provider_status VARCHAR,
    resource_allocation JSONB,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id),
    organization_id INTEGER REFERENCES organizations(id)
);

CREATE INDEX IF NOT EXISTS ix_fine_tuning_jobs_name ON fine_tuning_jobs(name);
CREATE INDEX IF NOT EXISTS ix_fine_tuning_jobs_user_id ON fine_tuning_jobs(user_id);
CREATE INDEX IF NOT EXISTS ix_fine_tuning_jobs_status ON fine_tuning_jobs(status);
CREATE INDEX IF NOT EXISTS ix_fine_tuning_jobs_provider ON fine_tuning_jobs(provider);

-- ============================================================================
-- 6. CHAT_CONVERSATIONS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS chat_conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR,
    session_id VARCHAR,
    user_id INTEGER NOT NULL REFERENCES users(id),
    organization_id INTEGER REFERENCES organizations(id),
    context JSONB,
    conversation_metadata JSONB,
    message_count INTEGER DEFAULT 0,
    last_message_at TIMESTAMP,
    status VARCHAR DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS ix_chat_conversations_session_id ON chat_conversations(session_id);
CREATE INDEX IF NOT EXISTS ix_chat_conversations_user_id ON chat_conversations(user_id);
CREATE INDEX IF NOT EXISTS ix_chat_conversations_status ON chat_conversations(status);

-- ============================================================================
-- 7. CHAT_MESSAGES TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS chat_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES chat_conversations(id) ON DELETE CASCADE,
    role VARCHAR NOT NULL,
    content TEXT NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS ix_chat_messages_conversation_id ON chat_messages(conversation_id);
CREATE INDEX IF NOT EXISTS ix_chat_messages_created_at ON chat_messages(created_at);

-- ============================================================================
-- 8. RFP_CRAWL_SOURCES TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS rfp_crawl_sources (
    id SERIAL PRIMARY KEY,
    donor_name VARCHAR(100) NOT NULL UNIQUE,
    source_type VARCHAR(50) NOT NULL,
    base_url TEXT,
    crawler_class VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    crawl_frequency_minutes INTEGER DEFAULT 1440,
    rate_limit_per_hour INTEGER DEFAULT 100,
    last_crawl_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS ix_rfp_crawl_sources_donor_name ON rfp_crawl_sources(donor_name);
CREATE INDEX IF NOT EXISTS ix_rfp_crawl_sources_is_active ON rfp_crawl_sources(is_active);

-- ============================================================================
-- 9. ORGANIZATION_CRAWL_PREFERENCES TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS organization_crawl_preferences (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    crawl_source_id INTEGER NOT NULL REFERENCES rfp_crawl_sources(id) ON DELETE CASCADE,
    is_enabled BOOLEAN DEFAULT TRUE,
    sectors TEXT[],
    min_budget DECIMAL(15, 2),
    max_budget DECIMAL(15, 2),
    regions TEXT[],
    keywords TEXT[],
    notification_enabled BOOLEAN DEFAULT TRUE,
    notification_channels JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS ix_organization_crawl_preferences_org_id ON organization_crawl_preferences(organization_id);
CREATE INDEX IF NOT EXISTS ix_organization_crawl_preferences_crawl_source_id ON organization_crawl_preferences(crawl_source_id);

-- ============================================================================
-- 10. RFP_CRAWL_JOBS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS rfp_crawl_jobs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    crawl_source_id INTEGER NOT NULL REFERENCES rfp_crawl_sources(id),
    status VARCHAR(50) NOT NULL,
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    rfps_discovered INTEGER DEFAULT 0,
    rfps_ingested INTEGER DEFAULT 0,
    rfps_duplicates INTEGER DEFAULT 0,
    error_message TEXT,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS ix_rfp_crawl_jobs_organization_id ON rfp_crawl_jobs(organization_id);
CREATE INDEX IF NOT EXISTS ix_rfp_crawl_jobs_status ON rfp_crawl_jobs(status);
CREATE INDEX IF NOT EXISTS ix_rfp_crawl_jobs_crawl_source_id ON rfp_crawl_jobs(crawl_source_id);

-- ============================================================================
-- 11. DISCOVERED_RFPS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS discovered_rfps (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    crawl_job_id UUID REFERENCES rfp_crawl_jobs(id),
    source_url TEXT NOT NULL,
    title TEXT NOT NULL,
    donor_name VARCHAR(100),
    deadline TIMESTAMP WITH TIME ZONE,
    budget_min DECIMAL(15, 2),
    budget_max DECIMAL(15, 2),
    currency VARCHAR(10) DEFAULT 'USD',
    sector VARCHAR(100),
    region VARCHAR(100),
    summary TEXT,
    raw_content TEXT,
    content_hash VARCHAR(64),
    relevance_score FLOAT,
    metadata JSONB,
    status VARCHAR(50) DEFAULT 'discovered',
    artifact_id UUID REFERENCES sankofa_artifacts(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS ix_discovered_rfps_organization_id ON discovered_rfps(organization_id);
CREATE INDEX IF NOT EXISTS ix_discovered_rfps_donor_name ON discovered_rfps(donor_name);
CREATE INDEX IF NOT EXISTS ix_discovered_rfps_deadline ON discovered_rfps(deadline);
CREATE INDEX IF NOT EXISTS ix_discovered_rfps_sector ON discovered_rfps(sector);
CREATE INDEX IF NOT EXISTS ix_discovered_rfps_content_hash ON discovered_rfps(content_hash);
CREATE INDEX IF NOT EXISTS ix_discovered_rfps_relevance_score ON discovered_rfps(relevance_score);
CREATE INDEX IF NOT EXISTS ix_discovered_rfps_status ON discovered_rfps(status);
CREATE INDEX IF NOT EXISTS ix_discovered_rfps_created_at ON discovered_rfps(created_at);

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- All critical tables have been created with proper indexes and foreign keys

