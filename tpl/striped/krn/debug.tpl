<div class="banner">
    <h1>Cerberus - Debugging Code</h1>
    <div class="message">
        <label>
                <pre>{print_r($mixed)}
                    </pre>
        </label>
        <label>
            <hr>
            <label>Debug Trace:</label>
            {foreach from=$trace item="action"}
                <hr>
                <ul>
                    <li>File: {$action['file']}</li>
                    <li>Line: {$action['line']}</li>
                    <li>Class: {$action['class']}</li>
                    <li>Function: {$action['function']}</li>
                </ul>
            {/foreach}
        </label>
    </div>
</div>