;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-zA-Z]+(?:[_\.\-]?[0-9a-zA-Z]+)*[@](?:[0-9a-zA-Z]+(?:[_\.\-]?[0-9a-zA-Z]+)*\.[a-zA-Z]{2,}|(?:\d{1,}\.){3}\d{1,}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Q_Vz@0.9.Zcy"
(define-fun Witness1 () String (seq.++ "Q" (seq.++ "_" (seq.++ "V" (seq.++ "z" (seq.++ "@" (seq.++ "0" (seq.++ "." (seq.++ "9" (seq.++ "." (seq.++ "Z" (seq.++ "c" (seq.++ "y" "")))))))))))))
;witness2: "yZ14316Z8@984.wZZ"
(define-fun Witness2 () String (seq.++ "y" (seq.++ "Z" (seq.++ "1" (seq.++ "4" (seq.++ "3" (seq.++ "1" (seq.++ "6" (seq.++ "Z" (seq.++ "8" (seq.++ "@" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "." (seq.++ "w" (seq.++ "Z" (seq.++ "Z" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "@" "@") (re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "." ".") (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.+ (re.range "0" "9")) (re.range "." "."))) (re.+ (re.range "0" "9"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
