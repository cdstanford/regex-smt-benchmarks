;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([(]?\d{3}[)]?(-| |.)?\d{3}(-| |.)?\d{4})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E9998\u00DD0398194Z"
(define-fun Witness1 () String (str.++ "\u{e9}" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "\u{dd}" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "4" (str.++ "Z" ""))))))))))))))
;witness2: "998)\u0096988\u00B08189\u008Bo\u0097\x15"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "8" (str.++ ")" (str.++ "\u{96}" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "\u{b0}" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "\u{8b}" (str.++ "o" (str.++ "\u{97}" (str.++ "\u{15}" ""))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.union (re.range " " " ") (re.range "-" "-")) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.union (re.range " " " ") (re.range "-" "-")) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
