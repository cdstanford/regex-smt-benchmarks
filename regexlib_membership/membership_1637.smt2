;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<Code>([^"']|"[^"]*")*)'(?<Comment>.*)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"\u00B6\"\'\u009F\u00C7\x13"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "\u{b6}" (str.++ "\u{22}" (str.++ "'" (str.++ "\u{9f}" (str.++ "\u{c7}" (str.++ "\u{13}" ""))))))))
;witness2: "\"\"\u00E3\'\u00C1"
(define-fun Witness2 () String (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "\u{e3}" (str.++ "'" (str.++ "\u{c1}" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "&") (re.range "(" "\u{ff}"))) (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}")))))(re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
