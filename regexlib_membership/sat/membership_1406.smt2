;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9]{4}[A-Z]{2}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9902UN"
(define-fun Witness1 () String (str.++ "9" (str.++ "9" (str.++ "0" (str.++ "2" (str.++ "U" (str.++ "N" "")))))))
;witness2: "\x1C9938CJ\xD\x14"
(define-fun Witness2 () String (str.++ "\u{1c}" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "C" (str.++ "J" (str.++ "\u{0d}" (str.++ "\u{14}" ""))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "A" "Z")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
