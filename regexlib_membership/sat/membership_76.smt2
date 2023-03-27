;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:[0-9]{4}-){3}[0-9]{4}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x1A5997-9398-9890-9486\u009A$\u00BDK\u00A9\u00A3"
(define-fun Witness1 () String (str.++ "\u{1a}" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "-" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "-" (str.++ "9" (str.++ "4" (str.++ "8" (str.++ "6" (str.++ "\u{9a}" (str.++ "$" (str.++ "\u{bd}" (str.++ "K" (str.++ "\u{a9}" (str.++ "\u{a3}" "")))))))))))))))))))))))))))
;witness2: "\u00DF2826-7842-9748-0188"
(define-fun Witness2 () String (str.++ "\u{df}" (str.++ "2" (str.++ "8" (str.++ "2" (str.++ "6" (str.++ "-" (str.++ "7" (str.++ "8" (str.++ "4" (str.++ "2" (str.++ "-" (str.++ "9" (str.++ "7" (str.++ "4" (str.++ "8" (str.++ "-" (str.++ "0" (str.++ "1" (str.++ "8" (str.++ "8" "")))))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
