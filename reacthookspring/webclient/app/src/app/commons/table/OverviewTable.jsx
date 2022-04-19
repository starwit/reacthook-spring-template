import React from "react";
import {TableHead, TableRow, Table, TableCell, TableBody} from "@mui/material";

function OverviewTable(props) {
    const {entities, columns, selected, onRowClick} = props;

    return (
        <Table>
            <TableHead>
                <TableRow>
                    {columns.map(column => <TableCell key={column.title}>{column.title}</TableCell>)}
                </TableRow>
            </TableHead>
            <TableBody>
                {entities.map(entity =>
                    <TableRow key={entity.id}
                        onClick={() => onRowClick(entity)}
                        selected={selected && entity.id === selected.id}
                    >
                        {columns.map(column =>
                            <TableCell key={entity.id + "." + column.field}>{entity[column.field]}</TableCell>)}
                    </TableRow>
                )}
            </TableBody>
        </Table>
    );
}

export default OverviewTable;
