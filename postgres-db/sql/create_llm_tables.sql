-- Create LLM-related tables for the Task Executor

-- LLM Models table
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

-- LLM Tasks table
CREATE TABLE IF NOT EXISTS llm_tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    description TEXT,
    task_type VARCHAR NOT NULL,
    model_id UUID REFERENCES llm_models(id),
    task_config JSONB,
    prompt_template_id UUID REFERENCES prompt_templates(id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER REFERENCES users(id)
);

-- LLM Executions table
CREATE TABLE IF NOT EXISTS llm_executions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    task_id UUID,  -- No foreign key constraint since tasks table may not exist
    model_id VARCHAR,
    prompt TEXT,
    response TEXT,
    execution_time_ms INTEGER,
    tokens_used INTEGER,
    cost FLOAT,
    status VARCHAR,
    error_message TEXT,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    input_data JSONB,
    output_data JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER REFERENCES users(id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_llm_models_user_id ON llm_models(user_id);
CREATE INDEX IF NOT EXISTS idx_llm_models_organization_id ON llm_models(organization_id);
CREATE INDEX IF NOT EXISTS idx_llm_models_provider ON llm_models(provider);
CREATE INDEX IF NOT EXISTS idx_llm_models_status ON llm_models(status);

CREATE INDEX IF NOT EXISTS idx_llm_tasks_user_id ON llm_tasks(user_id);
CREATE INDEX IF NOT EXISTS idx_llm_tasks_model_id ON llm_tasks(model_id);
CREATE INDEX IF NOT EXISTS idx_llm_tasks_task_type ON llm_tasks(task_type);

CREATE INDEX IF NOT EXISTS idx_llm_executions_user_id ON llm_executions(user_id);
CREATE INDEX IF NOT EXISTS idx_llm_executions_task_id ON llm_executions(task_id);
CREATE INDEX IF NOT EXISTS idx_llm_executions_model_id ON llm_executions(model_id);
CREATE INDEX IF NOT EXISTS idx_llm_executions_status ON llm_executions(status);
CREATE INDEX IF NOT EXISTS idx_llm_executions_created_at ON llm_executions(created_at);

