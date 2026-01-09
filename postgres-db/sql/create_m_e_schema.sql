-- Sankofa M&E Platform - Database Schema
-- This script creates the M&E-specific tables for the platform

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Donors table - stores information about funding organizations
CREATE TABLE IF NOT EXISTS donors (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    organization_type VARCHAR(100),
    preferences JSONB,
    language_style JSONB,
    compliance_requirements JSONB,
    success_patterns JSONB,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- RFPs table - stores Request for Proposals documents and analysis
CREATE TABLE IF NOT EXISTS rfps (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    donor_id UUID REFERENCES donors(id),
    title TEXT NOT NULL,
    content TEXT,
    requirements JSONB,
    timeline JSONB,
    compliance_matrix JSONB,
    risk_score FLOAT,
    status VARCHAR(50) DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Proposals table - stores proposal documents and development status
CREATE TABLE IF NOT EXISTS proposals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    rfp_id UUID REFERENCES rfps(id),
    status VARCHAR(50) DEFAULT 'draft',
    sections JSONB,
    team JSONB,
    budget JSONB,
    compliance_status JSONB,
    win_probability FLOAT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Evaluations table - stores evaluation reports and findings
CREATE TABLE IF NOT EXISTS evaluations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    proposal_id UUID REFERENCES proposals(id),
    type VARCHAR(50), -- inception, midterm, final
    template_id UUID,
    content JSONB,
    data_sources JSONB,
    quality_score FLOAT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Evaluation templates table - stores report templates
CREATE TABLE IF NOT EXISTS evaluation_templates (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50), -- inception, midterm, final
    donor_id UUID REFERENCES donors(id),
    template_content JSONB,
    sections JSONB,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_rfps_donor_id ON rfps(donor_id);
CREATE INDEX IF NOT EXISTS idx_rfps_status ON rfps(status);
CREATE INDEX IF NOT EXISTS idx_proposals_rfp_id ON proposals(rfp_id);
CREATE INDEX IF NOT EXISTS idx_proposals_status ON proposals(status);
CREATE INDEX IF NOT EXISTS idx_evaluations_proposal_id ON evaluations(proposal_id);
CREATE INDEX IF NOT EXISTS idx_evaluations_type ON evaluations(type);
CREATE INDEX IF NOT EXISTS idx_evaluation_templates_donor_id ON evaluation_templates(donor_id);
CREATE INDEX IF NOT EXISTS idx_evaluation_templates_type ON evaluation_templates(type);

-- Add comments for documentation
COMMENT ON TABLE donors IS 'Funding organizations and their preferences';
COMMENT ON TABLE rfps IS 'Request for Proposals documents and analysis results';
COMMENT ON TABLE proposals IS 'Proposal documents and development status';
COMMENT ON TABLE evaluations IS 'Evaluation reports and findings';
COMMENT ON TABLE evaluation_templates IS 'Templates for different types of evaluation reports';
