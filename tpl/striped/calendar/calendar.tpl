<section class="box calendar">
    <div class="inner">
        <table>
            <caption>{$monthName} {$year}</caption>
            <thead>
                <tr>
                    <th scope="col" title="Monday">{$daysOfWeekNames[0]}</th>
                    <th scope="col" title="Tuesday">{$daysOfWeekNames[1]}</th>
                    <th scope="col" title="Wednesday">{$daysOfWeekNames[2]}</th>
                    <th scope="col" title="Thursday">{$daysOfWeekNames[3]}</th>
                    <th scope="col" title="Friday">{$daysOfWeekNames[4]}</th>
                    <th scope="col" title="Saturday">{$daysOfWeekNames[5]}</th>
                    <th scope="col" title="Sunday">{$daysOfWeekNames[6]}</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                {$col = $monthStart}
                {if $monthStart > 0}<td colspan="{$monthStart}" class="pad"><span>&nbsp;</span></td>{/if}
                {for $day=1 to $daysInMonth}
                    {if $col > 6}</tr><tr>{$col = 0}{/if}
                    <td{if $day == $today} class="today"{/if}><span><a href="#">{$day}</a></span></td>
                    {$col = $col + 1}
                {/for}
                {if $col < 7}<td class="pad" colspan="{$col + 7 - ($col * 2)}"><span>&nbsp;</span></td>{/if}
                </tr>
            </tbody>
        </table>
    </div>
</section>