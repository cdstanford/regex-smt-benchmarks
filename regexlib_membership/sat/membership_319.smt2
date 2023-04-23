;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\[url=?"?)([^\]"]*)("?\])([^\[]*)(\[/url\])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "[url\"]\x14\u00A8[/url]"
(define-fun Witness1 () String (str.++ "[" (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "\u{22}" (str.++ "]" (str.++ "\u{14}" (str.++ "\u{a8}" (str.++ "[" (str.++ "/" (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "]" "")))))))))))))))
;witness2: "cp[url\"][/url]"
(define-fun Witness2 () String (str.++ "c" (str.++ "p" (str.++ "[" (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "\u{22}" (str.++ "]" (str.++ "[" (str.++ "/" (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "]" "")))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (str.++ "[" (str.++ "u" (str.++ "r" (str.++ "l" "")))))(re.++ (re.opt (re.range "=" "=")) (re.opt (re.range "\u{22}" "\u{22}"))))(re.++ (re.* (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "\u{5c}") (re.range "^" "\u{ff}"))))(re.++ (re.++ (re.opt (re.range "\u{22}" "\u{22}")) (re.range "]" "]"))(re.++ (re.* (re.union (re.range "\u{00}" "Z") (re.range "\u{5c}" "\u{ff}"))) (str.to_re (str.++ "[" (str.++ "/" (str.++ "u" (str.++ "r" (str.++ "l" (str.++ "]" "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
