;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-zA-Z]+(?:[_\.\-]?[0-9a-zA-Z]+)*[@](?:[0-9a-zA-Z]+(?:[_\.\-]?[0-9a-zA-Z]+)*\.[a-zA-Z]{2,}|(?:\d{1,}\.){3}\d{1,}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Q_Vz@0.9.Zcy"
(define-fun Witness1 () String (str.++ "Q" (str.++ "_" (str.++ "V" (str.++ "z" (str.++ "@" (str.++ "0" (str.++ "." (str.++ "9" (str.++ "." (str.++ "Z" (str.++ "c" (str.++ "y" "")))))))))))))
;witness2: "yZ14316Z8@984.wZZ"
(define-fun Witness2 () String (str.++ "y" (str.++ "Z" (str.++ "1" (str.++ "4" (str.++ "3" (str.++ "1" (str.++ "6" (str.++ "Z" (str.++ "8" (str.++ "@" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "." (str.++ "w" (str.++ "Z" (str.++ "Z" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "@" "@") (re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "." ".") (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.+ (re.range "0" "9")) (re.range "." "."))) (re.+ (re.range "0" "9"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
