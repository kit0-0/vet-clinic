-- Create the clinic database
CREATE DATABASE clinic;

-- Create the medical_histories relation
CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT NOT NULL,
  status VARCHAR(150),
  FOREIGN KEY (patient_id) REFERENCES patients (id)
);

-- Create the invoices relation
CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
);

-- Create the invoice_items relation
CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  FOREIGN KEY (invoice_id) REFERENCES invoices (id),
  FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);

-- Create medical_history_treatments to relate medical_history and treatments
CREATE TABLE medical_history_treatments (
  medical_history_id INT,
  treatment_id INT,
  PRIMARY KEY (medical_history_id, treatment_id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id),
  FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);

-- Create indexes on foreign key columns
CREATE INDEX idx_mh_treat_medhist_id ON medical_history_treatments (medical_history_id);
CREATE INDEX idx_mh_treat_treat_id ON medical_history_treatments (treatment_id);

CREATE INDEX idx_inv_items_inv_id ON invoice_items (invoice_id);
CREATE INDEX idx_inv_items_treat_id ON invoice_items (treatment_id);

CREATE INDEX idx_invoices_medhist_id ON invoices (medical_history_id);

CREATE INDEX idx_medhist_patient_id ON medical_histories (patient_id);
