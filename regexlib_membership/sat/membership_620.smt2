;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\[b\])([^\[\]]+)(\[/b\])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "[b]\u00CB\u00D3[/b]/"
(define-fun Witness1 () String (str.++ "[" (str.++ "b" (str.++ "]" (str.++ "\u{cb}" (str.++ "\u{d3}" (str.++ "[" (str.++ "/" (str.++ "b" (str.++ "]" (str.++ "/" "")))))))))))
;witness2: "[b]\x4[/b]"
(define-fun Witness2 () String (str.++ "[" (str.++ "b" (str.++ "]" (str.++ "\u{04}" (str.++ "[" (str.++ "/" (str.++ "b" (str.++ "]" "")))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "[" (str.++ "b" (str.++ "]" ""))))(re.++ (re.+ (re.union (re.range "\u{00}" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}")))) (str.to_re (str.++ "[" (str.++ "/" (str.++ "b" (str.++ "]" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
