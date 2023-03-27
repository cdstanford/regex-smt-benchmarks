;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \[(?<name>[^\]]*)\](?<value>[^\[]*)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "[]"
(define-fun Witness1 () String (str.++ "[" (str.++ "]" "")))
;witness2: "[\u00C4]\x9\u00FA\u00DF\u00F9"
(define-fun Witness2 () String (str.++ "[" (str.++ "\u{c4}" (str.++ "]" (str.++ "\u{09}" (str.++ "\u{fa}" (str.++ "\u{df}" (str.++ "\u{f9}" ""))))))))

(assert (= regexA (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.range "\u{00}" "\u{5c}") (re.range "^" "\u{ff}")))(re.++ (re.range "]" "]") (re.* (re.union (re.range "\u{00}" "Z") (re.range "\u{5c}" "\u{ff}"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
