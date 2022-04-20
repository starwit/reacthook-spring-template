import {Container, Typography, Button} from "@mui/material";
import React, {useState, useMemo, useEffect} from "react";
import {useTranslation} from "react-i18next";
import OverviewTable from "../../commons/table/OverviewTable";
import ${entity.name}Rest from "../../services/${entity.name}Rest";
import {useHistory} from "react-router";
import {${entity.name?uncap_first}Fields} from "../../modifiers/${entity.name}Modifier";

function UserOverview() {
    const [selected, setSelected] = useState(undefined);
    const {t} = useTranslation();
    const ${entity.name?lower_case}Rest = useMemo(() => new ${entity.name}Rest(), []);
    const history = useHistory();
    const [${entity.name?uncap_first}All, set${entity.name}All] = useState();

    useEffect(() => {
        reload();
    }, []);

    function reload() {
        ${entity.name?lower_case}Rest.findAll().then(response => {
            set${entity.name}All(response.data);
        });
    }

    function goToCreate() {
        history.push("/${entity.name?lower_case}/create");
    }

    function goToUpdate() {
        if (!!selected) {
            history.push("/${entity.name?lower_case}/update/" + selected.id);
            setSelected(undefined);
        }
    }

    function handleDelete() {
        if (!!selected) {
            ${entity.name?lower_case}Rest.delete(selected.id).then(reload);
            setSelected(undefined);
        }
    }

    return (
        <Container>
            <Typography variant={"h2"} gutterBottom>{t("${entity.name?uncap_first}.title")}</Typography>
            <Button onClick={goToCreate} variant="contained" color="primary">{t("button.create")}</Button>
            <Button onClick={goToUpdate} variant="contained" color="primary" disabled={!selected?.id} >
                {t("button.update")}
            </Button>
            <Button onClick={handleDelete} variant="contained" color="primary" disabled={!selected?.id}>
                {t("button.delete")}
            </Button>
            <OverviewTable
                entities={${entity.name?uncap_first}All}
                prefix={"${entity.name?uncap_first}"}
                selected={selected}
                onSelect={setSelected}
                fields={${entity.name?uncap_first}Fields}/>
        </Container>
    );
}

export default UserOverview;
