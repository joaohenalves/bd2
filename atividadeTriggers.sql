CREATE OR REPLACE FUNCTION checaEstoque() RETURNS TRIGGER AS $$
    BEGIN
        IF NEW.quantity <=0 THEN
            DELETE FROM stock s WHERE s.eid = NEW.eid;
            DELETE FROM product p WHERE p.eid = NEW.eid;
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trgChEst AFTER UPDATE ON stock FOR EACH ROW EXECUTE PROCEDURE checaEstoque();


CREATE TABLE controle (
    usuario VARCHAR(50),
    hora TIMESTAMP,
    eid INTEGER
);

CREATE OR REPLACE FUNCTION armazenaControle() RETURNS TRIGGER AS $$
    BEGIN
        IF NEW.quantity < OLD.quantity THEN
            INSERT INTO controle (usuario, hora, eid) VALUES (current_user, current_timestamp, NEW.eid);
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trgArmCtrl AFTER UPDATE ON stock FOR EACH ROW EXECUTE PROCEDURE armazenaControle();