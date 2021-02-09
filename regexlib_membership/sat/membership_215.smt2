;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d{2}|\d{4})(?:\-)?([0]{1}\d{1}|[1]{1}[0-2]{1})(?:\-)?([0-2]{1}\d{1}|[3]{1}[0-1]{1})(?:\s)?([0-1]{1}\d{1}|[2]{1}[0-3]{1})(?::)?([0-5]{1}\d{1})(?::)?([0-5]{1}\d{1})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8309-30082518X\u00D2"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "3" (seq.++ "0" (seq.++ "9" (seq.++ "-" (seq.++ "3" (seq.++ "0" (seq.++ "0" (seq.++ "8" (seq.++ "2" (seq.++ "5" (seq.++ "1" (seq.++ "8" (seq.++ "X" (seq.++ "\xd2" ""))))))))))))))))
;witness2: "1189-09-2808:57:56"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "0" (seq.++ "9" (seq.++ "-" (seq.++ "2" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ ":" (seq.++ "5" (seq.++ "7" (seq.++ ":" (seq.++ "5" (seq.++ "6" "")))))))))))))))))))

(assert (= regexA (re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.opt (re.range ":" ":"))(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.range ":" ":")) (re.++ (re.range "0" "5") (re.range "0" "9"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
