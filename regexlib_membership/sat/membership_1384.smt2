;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .+\.([^.]+)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "w\x12.\u00FD\u00E0\u00F9\u00C5\u0083"
(define-fun Witness1 () String (str.++ "w" (str.++ "\u{12}" (str.++ "." (str.++ "\u{fd}" (str.++ "\u{e0}" (str.++ "\u{f9}" (str.++ "\u{c5}" (str.++ "\u{83}" "")))))))))
;witness2: "^\u00A3\u00E1\u00ED.U"
(define-fun Witness2 () String (str.++ "^" (str.++ "\u{a3}" (str.++ "\u{e1}" (str.++ "\u{ed}" (str.++ "." (str.++ "U" "")))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "\u{00}" "-") (re.range "/" "\u{ff}"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
