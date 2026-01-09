-- Create model_registry table if it doesn't exist
CREATE TABLE IF NOT EXISTS model_registry (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    version VARCHAR NOT NULL,
    framework VARCHAR NOT NULL,
    algorithm VARCHAR NOT NULL,
    status VARCHAR NOT NULL DEFAULT 'training',
    parameters JSONB,
    metrics JSONB,
    dataset VARCHAR,
    performance JSONB,
    model_metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id),
    hpo_config_id UUID,
    pipeline_id UUID,
    pipeline_execution_id UUID
);

-- Create index on name if it doesn't exist
CREATE INDEX IF NOT EXISTS ix_model_registry_name ON model_registry(name);

-- Create index on user_id for faster queries
CREATE INDEX IF NOT EXISTS ix_model_registry_user_id ON model_registry(user_id);

-- Create index on status for filtering
CREATE INDEX IF NOT EXISTS ix_model_registry_status ON model_registry(status);

