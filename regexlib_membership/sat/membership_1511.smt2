;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .\{\d\}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "I{9}"
(define-fun Witness1 () String (str.++ "I" (str.++ "{" (str.++ "9" (str.++ "}" "")))))
;witness2: "\u00F5\u00AA\u00D8\u008D{8}"
(define-fun Witness2 () String (str.++ "\u{f5}" (str.++ "\u{aa}" (str.++ "\u{d8}" (str.++ "\u{8d}" (str.++ "{" (str.++ "8" (str.++ "}" ""))))))))

(assert (= regexA (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "{" "{")(re.++ (re.range "0" "9") (re.range "}" "}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
