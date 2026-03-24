#!/bin/bash
# resume-plan.sh
# Detects task_plan.md and injects summary (not full file) into context
# By Huzefa Nalkheda Wala | github.com/huzaifa525 | claude-code-optimizer

PLAN_FILE="task_plan.md"

if [ -f "$PLAN_FILE" ]; then
    echo ""
    echo "## Active Plan Detected"
    echo ""
    echo "Found \`task_plan.md\` — read it and continue from the CURRENT step."
    echo ""
    # Show only first 30 lines to avoid context bloat
    head -30 "$PLAN_FILE"
    TOTAL=$(wc -l < "$PLAN_FILE")
    if [ "$TOTAL" -gt 30 ]; then
        echo ""
        echo "... ($TOTAL total lines — read the full file to see remaining steps)"
    fi
    echo ""
fi

exit 0
