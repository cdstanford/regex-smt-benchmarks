;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [A-Z][a-z]+
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00D0Aeh"
(define-fun Witness1 () String (str.++ "\u{d0}" (str.++ "A" (str.++ "e" (str.++ "h" "")))))
;witness2: "\u00C8V\u00E3Jja="
(define-fun Witness2 () String (str.++ "\u{c8}" (str.++ "V" (str.++ "\u{e3}" (str.++ "J" (str.++ "j" (str.++ "a" (str.++ "=" ""))))))))

(assert (= regexA (re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
