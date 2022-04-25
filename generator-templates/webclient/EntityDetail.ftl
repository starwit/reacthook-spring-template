import {Container, Typography} from "@mui/material";
import React, {useState, useMemo, useEffect} from "react";
import {useImmer} from "use-immer";
import {useTranslation} from "react-i18next";
import UpdateForm from "./../../commons/form/UpdateForm";
import {useParams, useHistory} from "react-router";
import ${entity.name}Rest from "../../services/${entity.name}Rest";
import {handleChange} from "../../modifiers/DefaultModifier";
import {${entity.name?uncap_first}Fields, ${entity.name?uncap_first}Default} from "../../modifiers/${entity.name}Modifier";

function ${entity.name}Detail() {
    const {t} = useTranslation();
    const history = useHistory();
    const ${entity.name?lower_case}Rest = useMemo(() => new ${entity.name}Rest(), []);

    const [${entity.name?uncap_first}, set${entity.name}] = useImmer(${entity.name?uncap_first}Default);
    const [titleKey, setTitleKey] = useState(null);
    const {id} = useParams();

    useEffect(() => {
        onIdChange();
    }, [id]);

    function onIdChange() {
        if (!id) {
            setTitleKey("${entity.name?uncap_first}.create.title");
        } else {
            setTitleKey("${entity.name?uncap_first}.update.title");
            ${entity.name?lower_case}Rest.findById(id).then(response => {
                set${entity.name}(response.data);
            });
        }
    }

    function handleSubmit(event) {
    // turn off page reload
        event.preventDefault();

        if (!id) {
            ${entity.name?lower_case}Rest.create(${entity.name?uncap_first}).then(goBack);
        } else {
            ${entity.name?lower_case}Rest.update(${entity.name?uncap_first}).then(goBack);
        }
    }

    const goBack = () => {
        history.push("/${entity.name?lower_case}");
    };

    return (
        <Container>
            <Typography variant="h1" color="primary">{t(titleKey)}</Typography>
            <UpdateForm
                entity={${entity.name?uncap_first}}
                fields={${entity.name?uncap_first}Fields}
                prefix='${entity.name?uncap_first}'
                handleSubmit={handleSubmit}
                handleChange={e => handleChange(e, set${entity.name})}
            />
        </Container>
    );
}

export default ${entity.name}Detail;
