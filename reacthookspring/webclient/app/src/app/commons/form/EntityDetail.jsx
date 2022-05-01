import {
    Container,
    Typography,
    FormControl,
    InputLabel,
    Select,
    MenuItem,
    Button,
    OutlinedInput,
    Chip,
    Checkbox,
    ListItemText
} from "@mui/material";
import React, {useEffect, useState} from "react";
import {useTranslation} from "react-i18next";
import {useHistory} from "react-router";
import EntityDetailStyles from "./EntityDetailStyles.js";

import {
    handleChange,
    handleSelect,
    handleMultiSelect,
    isValid,
    prepareForSave,
    isInput,
    isSelect,
    isMultiSelect
} from "../../modifiers/DefaultModifier";
import UpdateField from "./UpdateField";
import {Box} from "@mui/system";

function EntityDetail(props) {
    const {entity, setEntity, fields, setFields, prefix, entityRest, id} = props;
    const {t} = useTranslation();
    const history = useHistory();
    const entityDetailStyles = EntityDetailStyles();

    const [titleKey, setTitleKey] = useState(null);
    const [hasFormError, setHasFormError] = React.useState(false);

    useEffect(() => {
        onIdChange();
    }, [id]);

    useEffect(() => {
        onEntityChange();
    }, [entity]);

    function onEntityChange() {
        setHasFormError(!isValid(fields, entity));
    }

    function onIdChange() {
        if (!id) {
            setTitleKey(prefix + ".create.title");
        } else {
            setTitleKey(prefix + ".update.title");
        }
    }

    function handleSubmit(event) {
    // turn off page reload
        event.preventDefault();
        const tmpOrg = prepareForSave(entity, fields);
        setEntity(tmpOrg);
        if (!id) {
            entityRest.create(tmpOrg).then(goBack);
        } else {
            entityRest.update(tmpOrg).then(goBack);
        }
    }

    const goBack = () => {
        history.push("/" + prefix);
    };

    return (
        <Container>
            <Typography variant="h1" color="primary">{t(titleKey)}</Typography>
            <form autoComplete="off" onSubmit={handleSubmit}>
                {fields?.map(field => {
                    if (isInput(field.type)) {
                        return (
                            <div key={field.name}>
                                <UpdateField
                                    entity={entity}
                                    field={field}
                                    prefix={prefix}
                                    handleChange={e => handleChange(e, setEntity)}
                                    fullWidth
                                />
                            </div>
                        );
                    } else if (isSelect(field.type)) {
                        return (
                            <div key={field.name}>
                                <FormControl fullWidth>
                                    <InputLabel id={"select-label-"+ field.name}>
                                        {t(prefix + "." + field.name)}
                                    </InputLabel>
                                    <Select
                                        labelId={"select-label-"+ field.name}
                                        id={"select-id-"+ field.name}
                                        name={field.name}
                                        value={entity[field.name] ? entity[field.name].id : -1}
                                        label={t(prefix + "." + field.name)}
                                        onChange={e => handleSelect(e, setEntity)}
                                    >
                                        <MenuItem value={-1} key={-1}>{t("select.none")}</MenuItem>
                                        {field.selectList?.map(item => (
                                            <MenuItem value={item.id} key={item.id}>
                                                {field.display?.map(attr => item[attr] + " ")}
                                            </MenuItem>
                                        ))}
                                    </Select>
                                </FormControl>
                            </div>
                        );
                    } else if (isMultiSelect(field.type)) {
                        return (
                            <div key={field.name}>
                                <FormControl fullWidth >
                                    <InputLabel id={"multiple-label-" + [field.name]}>
                                        {t(prefix + "." + field.name)}
                                    </InputLabel>
                                    <Select
                                        labelId={"multi-label-"+ field.name}
                                        id={"multi-id-"+ field.name}
                                        multiple
                                        value={field.selectedIds}
                                        label={t(prefix + "." + field.name)}
                                        onChange={e => handleMultiSelect(e, fields, setFields)}
                                        input={<OutlinedInput id="select-multiple-chip" label="Chip" />}
                                        renderValue={selected => (
                                            <Box className={entityDetailStyles.selectBox}>
                                                {selected.map(selectedId => {
                                                    const item = field.selectList?.find(e => e.id === selectedId);
                                                    if (field.selectList?.length > 0) {
                                                        return (
                                                            <Chip key={selectedId}
                                                                label={field.display?.map(attr => item[attr] + " ")}
                                                            />
                                                        );
                                                    }
                                                })}
                                            </Box>
                                        )}
                                    >
                                        {field.selectList?.map(item => (
                                            <MenuItem key={item.id} value={item.id}>
                                                <Checkbox checked={field.selectedIds?.includes(item.id)} />
                                                <ListItemText
                                                    primary= {field.display?.map(attr => item[attr] + " ")}
                                                />
                                            </MenuItem>
                                        ))}
                                    </Select>
                                </FormControl>
                            </div>

                        );
                    }
                })}
                <Button type="submit" variant="contained" color="primary" disabled={hasFormError} >
                    {t("button.submit")}
                </Button>
            </form>
        </Container>
    );
}

export default EntityDetail;
