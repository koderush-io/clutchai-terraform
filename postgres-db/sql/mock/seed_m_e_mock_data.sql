-- Sankofa M&E Platform - Mock Data
-- This script creates comprehensive mock data for testing the M&E pipeline

-- Insert sample donors
INSERT INTO donors (name, organization_type, preferences, language_style, compliance_requirements, success_patterns) VALUES
(
    'USAID',
    'Government',
    '{"focus_areas": ["health", "education", "economic_development"], "geographic_priority": ["Africa", "Asia"], "budget_range": [100000, 5000000]}',
    '{"tone": "formal", "style": "technical", "preferred_terms": ["development", "capacity building", "sustainability"]}',
    '{"certifications": ["ISO 9001", "USAID certification"], "reporting": ["quarterly", "annual"], "audit_requirements": true}',
    '{"winning_factors": ["local_partnerships", "measurable_outcomes", "cost_effectiveness"], "common_rejections": ["insufficient_local_capacity", "unrealistic_timelines"]}'
),
(
    'UNDP',
    'UN Agency',
    '{"focus_areas": ["sustainable_development", "climate_change", "governance"], "geographic_priority": ["global"], "budget_range": [50000, 2000000]}',
    '{"tone": "collaborative", "style": "inclusive", "preferred_terms": ["partnership", "sustainability", "inclusive_growth"]}',
    '{"certifications": ["UN standards"], "reporting": ["semi-annual"], "audit_requirements": true}',
    '{"winning_factors": ["multi_stakeholder_approach", "gender_inclusion", "environmental_sustainability"], "common_rejections": ["lack_of_gender_consideration", "insufficient_environmental_focus"]}'
),
(
    'Gates Foundation',
    'Private Foundation',
    '{"focus_areas": ["global_health", "education", "poverty_alleviation"], "geographic_priority": ["developing_countries"], "budget_range": [250000, 10000000]}',
    '{"tone": "innovative", "style": "data_driven", "preferred_terms": ["innovation", "measurable_impact", "scalability"]}',
    '{"certifications": ["financial_transparency"], "reporting": ["annual"], "audit_requirements": true}',
    '{"winning_factors": ["innovative_approach", "strong_evidence_base", "scalability_potential"], "common_rejections": ["lack_of_innovation", "insufficient_evidence"]}'
),
(
    'World Bank',
    'International Financial Institution',
    '{"focus_areas": ["infrastructure", "governance", "private_sector_development"], "geographic_priority": ["developing_countries"], "budget_range": [1000000, 50000000]}',
    '{"tone": "analytical", "style": "evidence_based", "preferred_terms": ["economic_impact", "institutional_capacity", "policy_reform"]}',
    '{"certifications": ["World Bank standards"], "reporting": ["quarterly"], "audit_requirements": true}',
    '{"winning_factors": ["strong_analytical_framework", "policy_impact", "institutional_capacity_building"], "common_rejections": ["weak_analytical_framework", "insufficient_policy_focus"]}'
);

-- Insert sample RFPs
INSERT INTO rfps (donor_id, title, content, requirements, timeline, compliance_matrix, risk_score, status) VALUES
(
    (SELECT id FROM donors WHERE name = 'USAID' LIMIT 1),
    'Health Systems Strengthening in East Africa',
    'The United States Agency for International Development (USAID) is seeking proposals for a comprehensive health systems strengthening program in East Africa. The program aims to improve healthcare delivery, strengthen health information systems, and build capacity of local health institutions.

Key Requirements:
- Minimum 5 years of experience in health systems strengthening
- Proven track record in East Africa
- Strong partnerships with local organizations
- Comprehensive monitoring and evaluation framework
- Gender-sensitive approach
- Cost-effective implementation strategy

Deliverables:
- Health system assessment report
- Capacity building program for health workers
- Health information system implementation
- Quarterly progress reports
- Final evaluation report

Budget: $2,500,000 - $3,500,000
Duration: 3 years
Deadline: 2024-03-15',
    '{"technical_requirements": ["health_systems_experience", "east_africa_experience", "local_partnerships", "m_e_framework"], "compliance_requirements": ["usaid_certification", "audit_capability", "quarterly_reporting"], "timeline_requirements": ["3_year_duration", "quarterly_deliverables"], "budget_requirements": ["2.5m_3.5m_budget", "cost_effectiveness"]}',
    '{"submission_deadline": "2024-03-15", "project_duration": "3 years", "key_milestones": ["month_6_assessment", "month_12_capacity_building", "month_24_system_implementation", "month_36_final_evaluation"]}',
    '{"technical_compliance": {"health_systems_experience": {"status": "pending", "evidence_required": true, "risk_level": "high"}, "east_africa_experience": {"status": "pending", "evidence_required": true, "risk_level": "medium"}}, "administrative_compliance": {"usaid_certification": {"status": "pending", "evidence_required": true, "risk_level": "high"}}, "financial_compliance": {"audit_capability": {"status": "pending", "evidence_required": true, "risk_level": "medium"}}}',
    0.6,
    'active'
),
(
    (SELECT id FROM donors WHERE name = 'UNDP' LIMIT 1),
    'Climate Change Adaptation in Small Island States',
    'The United Nations Development Programme (UNDP) is requesting proposals for a climate change adaptation program targeting small island developing states (SIDS). The program will focus on building resilience to climate impacts, promoting sustainable development, and strengthening local governance.

Key Requirements:
- Expertise in climate change adaptation
- Experience working with SIDS
- Strong environmental sustainability focus
- Multi-stakeholder engagement approach
- Gender and youth inclusion
- Innovative adaptation solutions

Deliverables:
- Climate vulnerability assessment
- Adaptation strategy development
- Community resilience building program
- Policy recommendations
- Knowledge sharing platform
- Semi-annual progress reports

Budget: $1,800,000 - $2,200,000
Duration: 4 years
Deadline: 2024-04-30',
    '{"technical_requirements": ["climate_adaptation_expertise", "sids_experience", "environmental_sustainability", "multi_stakeholder_approach"], "compliance_requirements": ["un_standards", "environmental_safeguards", "gender_inclusion"], "timeline_requirements": ["4_year_duration", "semi_annual_deliverables"], "budget_requirements": ["1.8m_2.2m_budget", "sustainability_focus"]}',
    '{"submission_deadline": "2024-04-30", "project_duration": "4 years", "key_milestones": ["month_6_vulnerability_assessment", "month_12_strategy_development", "month_24_implementation_start", "month_36_midterm_review", "month_48_final_evaluation"]}',
    '{"technical_compliance": {"climate_adaptation_expertise": {"status": "pending", "evidence_required": true, "risk_level": "high"}, "sids_experience": {"status": "pending", "evidence_required": true, "risk_level": "medium"}}, "administrative_compliance": {"un_standards": {"status": "pending", "evidence_required": true, "risk_level": "high"}}, "financial_compliance": {"environmental_safeguards": {"status": "pending", "evidence_required": true, "risk_level": "medium"}}}',
    0.4,
    'active'
),
(
    (SELECT id FROM donors WHERE name = 'Gates Foundation' LIMIT 1),
    'Digital Health Innovation for Maternal and Child Health',
    'The Bill & Melinda Gates Foundation is seeking innovative proposals for digital health solutions to improve maternal and child health outcomes in low-resource settings. The program will focus on scalable, technology-driven interventions that can be adapted across different contexts.

Key Requirements:
- Digital health innovation expertise
- Maternal and child health experience
- Strong evidence base and evaluation framework
- Scalability and sustainability focus
- Technology transfer capabilities
- Impact measurement systems

Deliverables:
- Digital health solution development
- Pilot implementation in 3 countries
- Impact evaluation study
- Scaling strategy
- Technology transfer plan
- Annual progress reports

Budget: $5,000,000 - $7,500,000
Duration: 5 years
Deadline: 2024-05-15',
    '{"technical_requirements": ["digital_health_expertise", "maternal_child_health", "innovation_capability", "scalability_focus"], "compliance_requirements": ["financial_transparency", "impact_measurement", "technology_transfer"], "timeline_requirements": ["5_year_duration", "annual_deliverables"], "budget_requirements": ["5m_7.5m_budget", "innovation_focus"]}',
    '{"submission_deadline": "2024-05-15", "project_duration": "5 years", "key_milestones": ["month_6_solution_design", "month_12_pilot_launch", "month_24_implementation", "month_36_evaluation", "month_48_scaling", "month_60_final_report"]}',
    '{"technical_compliance": {"digital_health_expertise": {"status": "pending", "evidence_required": true, "risk_level": "high"}, "innovation_capability": {"status": "pending", "evidence_required": true, "risk_level": "medium"}}, "administrative_compliance": {"financial_transparency": {"status": "pending", "evidence_required": true, "risk_level": "high"}}, "financial_compliance": {"impact_measurement": {"status": "pending", "evidence_required": true, "risk_level": "medium"}}}',
    0.7,
    'active'
);

-- Insert sample proposals
INSERT INTO proposals (rfp_id, status, sections, team, budget, compliance_status, win_probability) VALUES
(
    (SELECT id FROM rfps WHERE title = 'Health Systems Strengthening in East Africa' LIMIT 1),
    'draft',
    '{"executive_summary": "Draft in progress", "technical_approach": "Draft in progress", "team_qualifications": "Draft in progress", "budget": "Draft in progress", "monitoring_evaluation": "Draft in progress"}',
    '{"key_positions": ["Chief of Party", "Health Systems Specialist", "M&E Specialist", "Local Partnership Coordinator"], "total_team_size": 8, "specializations": ["Health Systems", "M&E", "East Africa Experience", "Local Partnerships"]}',
    '{"total_amount": 3000000, "breakdown": {"personnel": 1800000, "equipment": 600000, "travel": 300000, "other": 300000}, "assumptions": ["3 year duration", "8 person team", "quarterly reporting"]}',
    '{"technical_compliance": 0.8, "administrative_compliance": 0.6, "financial_compliance": 0.9}',
    0.75
),
(
    (SELECT id FROM rfps WHERE title = 'Climate Change Adaptation in Small Island States' LIMIT 1),
    'draft',
    '{"executive_summary": "Draft in progress", "technical_approach": "Draft in progress", "team_qualifications": "Draft in progress", "budget": "Draft in progress", "monitoring_evaluation": "Draft in progress"}',
    '{"key_positions": ["Project Director", "Climate Adaptation Specialist", "Environmental Specialist", "Community Engagement Coordinator"], "total_team_size": 6, "specializations": ["Climate Adaptation", "Environmental Sustainability", "SIDS Experience", "Community Engagement"]}',
    '{"total_amount": 2000000, "breakdown": {"personnel": 1200000, "equipment": 400000, "travel": 200000, "other": 200000}, "assumptions": ["4 year duration", "6 person team", "semi-annual reporting"]}',
    '{"technical_compliance": 0.9, "administrative_compliance": 0.8, "financial_compliance": 0.7}',
    0.85
);

-- Insert sample evaluation templates
INSERT INTO evaluation_templates (name, type, donor_id, template_content, sections) VALUES
(
    'USAID Inception Report Template',
    'inception',
    (SELECT id FROM donors WHERE name = 'USAID' LIMIT 1),
    '{"format": "USAID standard", "sections": ["executive_summary", "project_setup", "baseline_assessment", "work_plan", "risk_management"], "word_limit": 15000}',
    '{"executive_summary": {"required": true, "word_limit": 2000}, "project_setup": {"required": true, "word_limit": 3000}, "baseline_assessment": {"required": true, "word_limit": 4000}, "work_plan": {"required": true, "word_limit": 4000}, "risk_management": {"required": true, "word_limit": 2000}}'
),
(
    'UNDP Midterm Report Template',
    'midterm',
    (SELECT id FROM donors WHERE name = 'UNDP' LIMIT 1),
    '{"format": "UNDP standard", "sections": ["executive_summary", "progress_assessment", "challenges_lessons", "recommendations", "next_steps"], "word_limit": 20000}',
    '{"executive_summary": {"required": true, "word_limit": 3000}, "progress_assessment": {"required": true, "word_limit": 6000}, "challenges_lessons": {"required": true, "word_limit": 4000}, "recommendations": {"required": true, "word_limit": 4000}, "next_steps": {"required": true, "word_limit": 3000}}'
),
(
    'Gates Foundation Final Report Template',
    'final',
    (SELECT id FROM donors WHERE name = 'Gates Foundation' LIMIT 1),
    '{"format": "Gates Foundation standard", "sections": ["executive_summary", "impact_assessment", "innovation_highlights", "scalability_analysis", "lessons_learned"], "word_limit": 25000}',
    '{"executive_summary": {"required": true, "word_limit": 4000}, "impact_assessment": {"required": true, "word_limit": 8000}, "innovation_highlights": {"required": true, "word_limit": 5000}, "scalability_analysis": {"required": true, "word_limit": 5000}, "lessons_learned": {"required": true, "word_limit": 3000}}'
);

-- Insert sample evaluations
INSERT INTO evaluations (proposal_id, type, template_id, content, data_sources, quality_score) VALUES
(
    (SELECT id FROM proposals WHERE rfp_id = (SELECT id FROM rfps WHERE title = 'Health Systems Strengthening in East Africa' LIMIT 1) LIMIT 1),
    'inception',
    (SELECT id FROM evaluation_templates WHERE name = 'USAID Inception Report Template' LIMIT 1),
    '{"executive_summary": "Draft in progress", "project_setup": "Draft in progress", "baseline_assessment": "Draft in progress", "work_plan": "Draft in progress", "risk_management": "Draft in progress"}',
    '{"baseline_surveys": ["health_facility_assessment", "health_worker_capacity"], "secondary_data": ["health_statistics", "demographic_data"], "stakeholder_interviews": ["health_officials", "community_representatives"]}',
    0.8
);

-- Update the updated_at timestamps
UPDATE donors SET updated_at = NOW();
UPDATE rfps SET updated_at = NOW();
UPDATE proposals SET updated_at = NOW();
UPDATE evaluations SET updated_at = NOW();
UPDATE evaluation_templates SET updated_at = NOW();
