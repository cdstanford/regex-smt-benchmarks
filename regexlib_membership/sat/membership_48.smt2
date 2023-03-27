;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9]{4}[0-3]{1}[0-9}{1}[0-9]{5}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "95981986}8"
(define-fun Witness1 () String (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "}" (str.++ "8" "")))))))))))
;witness2: "569829[5{8\u00ED"
(define-fun Witness2 () String (str.++ "5" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "[" (str.++ "5" (str.++ "{" (str.++ "8" (str.++ "\u{ed}" ""))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "0" "3") ((_ re.loop 5 5) (re.union (re.range "0" "9")(re.union (re.range "[" "[")(re.union (re.range "{" "{") (re.range "}" "}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
