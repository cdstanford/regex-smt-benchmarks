;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\/\/--&gt;\s*)?&lt;\/?SCRIPT([^&gt;]*)&gt;(\s*&lt;!--\s)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "//--&gt; &lt;/SCRIPT&gt;"
(define-fun Witness1 () String (seq.++ "/" (seq.++ "/" (seq.++ "-" (seq.++ "-" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ " " (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "S" (seq.++ "C" (seq.++ "R" (seq.++ "I" (seq.++ "P" (seq.++ "T" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))))))))
;witness2: "\u00B6//--&gt;&lt;SCRIPT\x1F&gt;"
(define-fun Witness2 () String (seq.++ "\xb6" (seq.++ "/" (seq.++ "/" (seq.++ "-" (seq.++ "-" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "S" (seq.++ "C" (seq.++ "R" (seq.++ "I" (seq.++ "P" (seq.++ "T" (seq.++ "\x1f" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (str.to_re (seq.++ "/" (seq.++ "/" (seq.++ "-" (seq.++ "-" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))))))) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (str.to_re (seq.++ "S" (seq.++ "C" (seq.++ "R" (seq.++ "I" (seq.++ "P" (seq.++ "T" "")))))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "f")(re.union (re.range "h" "s") (re.range "u" "\xff"))))))(re.++ (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" ""))))) (re.opt (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "!" (seq.++ "-" (seq.++ "-" "")))))))) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
