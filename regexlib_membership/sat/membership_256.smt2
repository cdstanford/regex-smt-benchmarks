;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{2})(01|02|03|04|05|06|07|08|09|10|11|12|51|52|53|54|55|56|57|58|59|60|61|62)(([0]{1}[1-9]{1})|([1-2]{1}[0-9]{1})|([3]{1}[0-1]{1}))/([0-9]{3,4})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "955109/179"
(define-fun Witness1 () String (str.++ "9" (str.++ "5" (str.++ "5" (str.++ "1" (str.++ "0" (str.++ "9" (str.++ "/" (str.++ "1" (str.++ "7" (str.++ "9" "")))))))))))
;witness2: "096208/894"
(define-fun Witness2 () String (str.++ "0" (str.++ "9" (str.++ "6" (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "/" (str.++ "8" (str.++ "9" (str.++ "4" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (str.to_re (str.++ "0" (str.++ "1" "")))(re.union (str.to_re (str.++ "0" (str.++ "2" "")))(re.union (str.to_re (str.++ "0" (str.++ "3" "")))(re.union (str.to_re (str.++ "0" (str.++ "4" "")))(re.union (str.to_re (str.++ "0" (str.++ "5" "")))(re.union (str.to_re (str.++ "0" (str.++ "6" "")))(re.union (str.to_re (str.++ "0" (str.++ "7" "")))(re.union (str.to_re (str.++ "0" (str.++ "8" "")))(re.union (str.to_re (str.++ "0" (str.++ "9" "")))(re.union (str.to_re (str.++ "1" (str.++ "0" "")))(re.union (str.to_re (str.++ "1" (str.++ "1" "")))(re.union (str.to_re (str.++ "1" (str.++ "2" "")))(re.union (str.to_re (str.++ "5" (str.++ "1" "")))(re.union (str.to_re (str.++ "5" (str.++ "2" "")))(re.union (str.to_re (str.++ "5" (str.++ "3" "")))(re.union (str.to_re (str.++ "5" (str.++ "4" "")))(re.union (str.to_re (str.++ "5" (str.++ "5" "")))(re.union (str.to_re (str.++ "5" (str.++ "6" "")))(re.union (str.to_re (str.++ "5" (str.++ "7" "")))(re.union (str.to_re (str.++ "5" (str.++ "8" "")))(re.union (str.to_re (str.++ "5" (str.++ "9" "")))(re.union (str.to_re (str.++ "6" (str.++ "0" "")))(re.union (str.to_re (str.++ "6" (str.++ "1" ""))) (str.to_re (str.++ "6" (str.++ "2" ""))))))))))))))))))))))))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 3 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
